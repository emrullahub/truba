#!/bin/bash
usage() {
  ###### U S A G E : Help ######
  cat <<EOF
  Usage: truba <[options]>
  Options:
           -h   --help    Show this message
           -f   --fix     Fix truba server
           -v   --vpn     open truba server with vpn
EOF
}

# functions

# fixing truba

fix_truba(){
	`sudo pkill openvpn; sudo systemctl stop sshd`
}

# if you want to work with another truba server terminal

start_truba(){
expect <(cat <<'EOD'
        set basedir [file normalize [file dirname $argv0]]
        set secret_file [open "/home/emr/.dotfiles/.ssh/truba/auth_truba" r]
        gets $secret_file username; gets $secret_file password; gets $secret_file ip; gets $secret_file ovpn
        close $secret_file

        spawn ssh "${username}@${ip}"

        expect {
        "*Are you sure you want to continue*" { send "yes\r"; exp_continue }
        "*password:*"  { send "$password\r"; interact }
        }
        exit -onexit {
                #exec sudo pkill -9 openvpn
                puts "Bye bye!"
        }
EOD
)

}

# if you want to start with vpn
start_with_vpn(){
expect <(cat <<'EOD'

set basedir [file normalize [file dirname $argv0]]
set secret_file [open "/home/emr/.dotfiles/.ssh/truba/auth_truba" r]
gets $secret_file username; gets $secret_file password; gets $secret_file ip; gets $secret_file ovpn
close $secret_file

spawn openvpn --config "${ovpn}" --auth-nocache

expect {
        "*Username*"    { send "$username\r"; exp_continue}
        "*Password:*"   { send "$password\r"; exp_continue}
        "*Completed*"   { spawn ssh "${username}@${ip}" }
}
expect {
 "*Are you sure you want to continue*" { send "yes\r"; exp_continue }
 "*password:*"  { send "$password\r"; interact }
}

exit -onexit {
        #exec sudo pkill -9 openvpn
        puts "Bye bye!"
}
EOD
)
}


[[ $EUID -ne 0 ]] && echo "This script must be run as root." && exit 1

# if any options not entered
if [[ ! $@ =~ ^\-.+ ]]
then
  start_truba
fi

OPTS=`getopt -o hfv --longoptions help,fix,vpn -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi
eval set -- "$OPTS"

while true; do
        case "$1" in
                -h | --help ) usage; shift ;;
                -f | --fix ) 
			fix_truba
			shift 
			;;
                -v | --vpn ) 
			start_with_vpn
			shift ;;
                -- ) shift; break ;;
                * ) usage; break ;;
        esac
done
