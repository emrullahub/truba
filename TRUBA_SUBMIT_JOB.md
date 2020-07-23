#TRUBA SERVER'DA İŞ OLUŞTURMA

#####Örnek iş başlığı:
```bash
#!/bin/bash
#SBATCH --job-name is_ismi
#SBATCH --partition=single
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=output_dosyasi
#SBATCH -mail-type=END
#SBATCH -mail-user=emrullahyilmazg@gmail.com
```

- İş örneğindeki parametrelere dair açıklamalar:

###SBATCH -J → İşin adı.

Örnek:
```bash
#SBATCH --job-name is_ismi```

###SBATCH -p -> İşin çalıştırılacağı kuyruk adı (partition)

[Truba partitions bilgileri için tıklayın.](http://wiki.truba.gov.tr/index.php/TRUBA-levrek#Kuyruklar_.28Partitions.29)
Örnek:
```bash
#SBATCH --partition single```

###SBATCH --time
-İşin en fazla ne kadar süre çalışacağını belirtir. Bu süre zarfında tamamlanmamış olan işler, zaman dolduğunda otomatik olarak bitirilir. Burada verilecek değer ilgili kuyruğun sınırından yüksek olamaz (bkz. Kuyruklar - iş süreleri). Herhangi bir değer verilmeden gönderilen işler, çalışmaya başladıktan 1 dakika sonrasında sistem tarafından otomatik olarak sonlandırılır.

Örnek:
Zaman, "dakika", "dakika:saniye", "saat:dakika:saniye", "gün-saat", "gün-saat:dakika" ve "gün-saat:dakika:saniye" formatlarında belirtilebilir.

```bash
#SBATCH --time=12-05:35:40```
Verilen örnekte scriptin en uzun çalışma süresi 12 gün 5 saat 35 dakika 40 saniyedir.



###SBATCH -c

Bir iş için kullanılabilecek en fazla çekirdek sayısını belirtir (cores per task). Default=1. Değeri bir sunucudaki çekirdek sayısından fazla olamaz.

###SBATCH --threads
İşlemcilerin hyperthreading özelliklerini kullanmak için tanımlanır. Mevcut işlemcilerde çekirdek başına 2 thread düşmektedir.

###SBATCH --mem
Bu parametre ile iş için toplamda en fazla ne kadar bellek kullanılacağı belirtilmektedir. Kullanımı zorunlu değildir.

###SBATCH -N
Hesaplama sırasında, kullanılacak çekirdeklerin kaç farklı node tarafından sağlanacağını belirler. Herhangi bir tanım girilmemişse, çekirdekler rastgele sayındaki nodelardan rastgele sayıda sağlanırlar. Node sayısı için herhangi bir tanımlama yapmamak işlerin mümkün olan en hızlı şekilde başlamasını sağlar, ancak performans testlerinde alıncak sonuç, her iş için farklı olabilir.


###SBATCH –workdir
İşin başlayıp, output err dosyalarının yazılacağı dizinin adresidir. Eğer herhangi bir tanımlama yapılmaz ise, varsayılan olarak iş gönderilirken o an içinde bulunan dizin workdir dizini olarak kabul edilir.

###SBATCH -mail-type
İş kuyruğa gönderildikten sonra, iş ile ilgili ne tür e-postaların gönderileceğini tanımlar. BEGIN, END, FAIL, REQUEUE, ALL değerlerini alabilir. Herhangi bir tanım yapılmaz ise kullanıcı e-posta ile bilgilendirilmez.

###SBATCH -mail-user
Yukarıda tanımlanan durumlarda e-postanın gönderileceği adresi tanımlar.
Örnek:
```bash
#SBATCH -mail-type=END
#SBATCH -mail-user=emrullahyilmazg@gmail.com```
Bu örnek, iş bittiği (END) zaman emrullahyilmazg@gmail.com mail adresine bildirim gönderecektir.

   ##TERMİNAL’DEKİ KOMUTLAR

**squeue**
Kullanıcının kuyrukta bekleyen ve çalışan işlerini görüntüler. Kullanılacak ek parametrelerle, listelenecek bilginin türü ve miktarı değiştirilebilir. Kullanıcının tüm işleri listelenebileceği gibi (varsayılan), işin iş numarası parametre olarak verilerek, o işe özel bilgilerin dökümü de alınabilir.

Örnek:
```bash
emyilmaz@levrek1:[~/study-class]: squeue -u emyilmaz```
```bash
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
3528522    single          job1.sh   emyilmaz  R    1:12      1 		levrek147
3528523    single          job2.sh   emyilmaz  R    1:12      1 		levrek147```

Örnekte -u --user olarak da açılabilir. Yukarıdaki komut emyilmaz kullanıcısının çalıştırdığı işleri getir anlamına gelmektedir.


**sbatch**
Hazırlanan işi(ornek.sh, ornek2.sh) serverda başlatmak üzere kullanılır.
```bash
emyilmaz@levrek1:[~/study-class]: sbatch ornek.sh```

```
sbatch: 1 çekirdekli isler sadece Single ve Mercan kuyruklarina gönderilebilir. İşiniz Single kuyruğuna yonlendirilmistir.
Submitted batch job 3528522```

Başka örnek:
```bash
emyilmaz@levrek1:[~/study-class]: sbatch ornek2.sh```

```
sbatch: 1 cekirdekli isler sadece Single ve Mercan kuyruklarina gönderilebilir. İşiniz Single kuyruğuna yonlendirilmistir.
Submitted batch job 352852```

**scancel** 
Kuyrukta sırada bekleyen ya da o anda çalışmakta olan işleri iptal etmek için kullanılır. İki şekilde kullanabiliriz: 
```bash 
emyilmaz@levrek1:[~/study-class]: squeue```
```
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
3528621    single 		  ornek.sh emyilmaz  R    0:27      1 			levrek147```

- Verdiğimiz iş ismine göre iptal edebiliriz.
```bash
emyilmaz@levrek1:[~/study-class]: scancel --name=ornek.sh```

```bash
emyilmaz@levrek1:[~/study-class]: squeue```
```bash
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
emyilmaz@levrek1:[~/study-class]:```

- Otomatik atanan iş ID numarasına göre iptal edebiliriz.
```bash
emyilmaz@levrek1:[~/study-class]: squeue```
```bash
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
3528626    single        ornek.sh emyilmaz PD   0:00      1         (Priority)```

```bash
emyilmaz@levrek1:[~/study-class]: scancel 3528626```

```bash
emyilmaz@levrek1:[~/study-class]: squeue
         JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)

emyilmaz@levrek1:[~/study-class]:```




**sinfo**
İş kuyruklarının güncel kullanım durumunu ekrana basar. Buradan alınacak bilgi ile kuyruğa gönderilecek işin kaynak miktarı planlanarak en hızlı şekilde başlayabileceği kuyruğa yönlendirilebilir.Kullanılacak ek parametrelerle, listelenecek bilginin türü ve miktarı değiştirilebilir.
Kuyrukların kullanım durumuna, paylaşılan dolu yada boş olan node ve çekirdeklerin durumuna “sinfo” komutu ile erişilebilir.

```bash
emyilmaz@levrek1:[~/study-class]: sinfo --nodes=levrek```
```bash 
PARTITION     AVAIL  TIMELIMIT  NODES  STATE NODELIST
mercan*          up 15-00:00:0      0    n/a 
single           up 15-00:00:0      0    n/a 
levrekv2         up 15-00:00:0      0    n/a 
levrekv2-cuda    up 15-00:00:0      0    n/a 
smp              up 8-00:00:00      0    n/a 
sardalya         up 15-00:00:0      0    n/a 
barbun           up 15-00:00:0      0    n/a 
barbun-cuda      up 15-00:00:0      0    n/a 
akya-cuda        up 15-00:00:0      0    n/a 
short            up    4:00:00      0    n/a 
mid1             up 4-00:00:00      0    n/a 
mid2             up 8-00:00:00      0    n/a 
long             up 15-00:00:0      0    n/a 
debug            up      15:00      0    n/a```

```bash
emyilmaz@levrek1:[~/study-class]: sinfo --nodes=levrek | wc -l
15```

**Not: wc -l → Listedeki satır sayısını verir. Sonuçta 14 satır + header ile toplam 15 satır yer alır.**

**scontrol**
Herhangi bir kuyruğun bilgisine aşağıdaki komutla erişilebilir:
```bash
scontrol show partition=kuyruk_adi```
###TRUBA SERVER’A MODÜL YÜKLEME

```bash
mod | grep modül ismi```

(module avail | grep “modül ismi” → bu komut hata verdiği için düzenlendi.) İstediğimiz modülün serverda var olup olmadığını ya da versiyon kontrolü yapmak istediğimiz zaman kullanılır.

```bash
module load modul_ismi```
Modülü servera yüklemek için kullanılır.

[Daha fazla bilgi edinmek için tıklayın.](http://wiki.truba.gov.tr/index.php/TRUBA-levrek)
