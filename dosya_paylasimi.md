# Kümedeki diğer kullanıcılar ile dosya paylaşımı yapma

Dosya paylaşımı yaparken `setfacl` komutunu kullanabilirsiniz. Bu komut sudo yetkileri gerektirmeyeceği için herhangi bir kullanıcı dosyasını istediği diğer bir kullanıcı ile paylaşabilir.

`setfacl -d -m u:username:rwx PATH/TO/FILE`

`r` okuma yetkisini (read), `w` yazma yetkisini (write) ve `x` çalıştırma (execute) yetkisini belirtir. Vermek istemediğiniz bir yetki için basitçe `-` kullanabilirsiniz. Örneğin, `r-x` şeklinde belirtilen yetki sadece okuma ve çalıştırmaya izin verecektir.

`d` yetkisi verildiğinde default acl tanımlaması yapılır, bu da o dizin altında açılacak yeni dosya veya alt dizinlerde verilen yetkinin otomatik olarak tanımlanmasını sağlar.

`setfacl -m u:username:rwx PATH/TO/FILE`
