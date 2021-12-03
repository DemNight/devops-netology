# devops-netology
## какое-то из первых дз

1) система исключит файлы с именем .tfvars (скрытый файл?)

2) файлы с именем ("точное имя")

override.tf
override.tf.json

а так же все файлы имеющие "хвост" (после нижнего подчёркивания, включая само подчёркивание)

_override.tf
_override.tf.json

3) будут игнорироваться файлы 

с именем .terraformrc (скрытый файл?)
и файл с именем terraform.rc


# 3.1. Работа в терминале, лекция 1

1) Установите средство виртуализации Oracle VirtualBox.
```
Сделано
```
2) Установите средство автоматизации Hashicorp Vagrant.
```
Сделано
```
3) В вашем основном окружении подготовьте удобный для дальнейшей работы терминал.
```
сделано
```
4) С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant:

Создайте директорию, в которой будут храниться конфигурационные файлы Vagrant. В ней выполните vagrant init. Замените содержимое Vagrantfile по умолчанию следующим:

 Vagrant.configure("2") do |config|
 	config.vm.box = "bento/ubuntu-20.04"
 end
 
Выполнение в этой директории vagrant up установит провайдер VirtualBox для Vagrant, скачает необходимый образ и запустит виртуальную машину.
```
Сделано
```
5) Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?
```
2 cpu,
1024 ram,
64 gb на жёстком диске (динамический жёсткий диск, занято 1.75 гб),
подключена сеть
9 мб видеопамяти
```
6) Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
```
путём добавления в файл конфигурации строк:

config.vm.provider "virtualbox" do |v|

  v.memory = указать_объём_памяти_(мб)
  
  v.cpus = указать_количество_ядер_цп
  
end
```
7) Команда vagrant ssh из директории, в которой содержится Vagrantfile, позволит вам оказаться внутри виртуальной машины без каких-либо дополнительных настроек. Попрактикуйтесь в выполнении обсуждаемых команд в терминале Ubuntu.
```
Подключение установлено
```
8) Ознакомиться с разделами man bash, почитать о настройках самого bash:

- какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?
```
HISTFILESIZE

стр 1 строка 778
```
- что делает директива ignoreboth в bash?
```
Не сохраняет в истории команды повторяющиеся и начинающиеся с пробела команды
```
9) В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?
```
в сценариях когда требуется одновременно создать\удалить множество директорий и\или файлов, изменить права доступак ним, переместить в другие директории

стр 1 строка 1001
```
10) С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?
```
touch ИМЯ_ФАЙЛА{1..100000}

300000 не получится, тк слижком большое значение аргумента (ограничение ОС)
```
11) В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]
```
проверяет условие -d /tmp, наличие каталога и возвращает 1 или 0 (истина\ложь) в зависимости от результатов проверки.
```
12)Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:
```
mkdir /tmp/new_path_directory/
cp /bin/bash /tmp/new_path_directory/
PATH=/tmp/new_path_directory/:$PATH
type -a bash

bash is /tmp/new_path_directory/bash
bash is /usr/bin/bash
bash is /bin/bash

(добавил скриншот)
```
13)Чем отличается планирование команд с помощью batch и at?
```
at - запускает выполнение задач в заданное время (однократный запуск).

batch - позволяет запустить задачи, когда средняя нагрузка на систему ниже указанной (до этого момента, задачи висят в очереди).  
```
14) Завершите работу виртуальной машины чтобы не расходовать ресурсы компьютера и/или батарею ноутбука.
```
работа завершена (sudo shutdown -h now)
```


# 3.2. Работа в терминале, лекция 2

1) Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.
```
cd является внутренней командой ос. Проще делать смену директории находясь внутри любой директории ос, 
не вызывая внешней "оплётки" со своим окружением. 
```
2) Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l? man grep поможет в ответе на этот вопрос. Ознакомьтесь с документом о других подобных некорректных вариантах использования pipe.
```
vagrant@vagrant:~$ cat test-1
11
22
33
44
55
vagrant@vagrant:~$ grep 22 test-1 -c
1
vagrant@vagrant:~$ grep 22 test-1 -c | wc -l
1
```
3)Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?
```
vagrant@vagrant:~$ pstree -p
systemd(1)─┬─VBoxService(814)─┬─{VBoxService}(815)
           │                  ├─{VBoxService}(816)
           │                  ├─{VBoxService}(817)
           │                  ├─{VBoxService}(818)
           │                  ├─{VBoxService}(819)
           │                  ├─{VBoxService}(820)
           │                  ├─{VBoxService}(821)
           │                  └─{VBoxService}(822)

```
4) Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?
```
vagrant@vagrant:~$ ls -l /dev/pts/0 2>/dev/pts/1

vagrant@vagrant:~$ who
vagrant  pts/0        2021-11-21 18:34 (10.0.2.2)
vagrant  pts/1        2021-11-21 18:55 (10.0.2.2)
vagrant  pts/2        2021-11-21 19:02 (10.0.2.2)
```

5) Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.
```
vagrant@vagrant:~$ cat test-1
11
22
33
44
55
vagrant@vagrant:~$ cat <test-1> test-1-out
vagrant@vagrant:~$ cat test-1-out
11
22
33
44
55
```
6) Получится ли находясь в графическом режиме, вывести данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?
```
Да, получится с использованием перенаправления (и наличием достаточных прав у пользователя)

vagrant@vagrant:/$ echo hello to tty2 > dev/tty2

(добавил скриншот)
```
7) Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?
```
bash 5>&1 - будет создан дискриктор 5, который будет перенаправлен stdout
echo netology > /proc/$$/fd/5 - если дескритор создан, команда отработает, на экране появится надпись "netology",
если нет - получим ошибку "файл или директория не существует"
```
8) Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от | на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.
```
Да, можно собрать "цепочку" перенаправлений 

Выглядеть будет примерно так: ls -l 5>&2 2>&1 1>&5 |grep some -c
```
9) Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?
```
Переменные среды

можно использовать команду: env
```
10) Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe
```
/proc/<PID>/exe - ссылка до файла запущенного для процесса с указанным PID
 
/proc/<PID>/cmdline - полный путь до исполняемого файла процесса с указанным PID
```
11) Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo.
```
grep sse /proc/cpuinfo

sse4.2
```
12) При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty. Это можно подтвердить командой tty, которая упоминалась в лекции 3.2. Однако:
```
vagrant@netology1:~$ ssh localhost 'tty'
not a tty

то, что смог найти (вроде, похоже на правду) и если я правильно понял:

По умолчанию TTY, при выполнении команды (ssh) на удалённой машине, не выделяется. если запустить без удалённой команды, он стартанёт.
но будет ждать открытия оболочки. оболочка не запустится, тк по умолчанию tty не выделяется. 

Если требуется запустится в таком варианте, интернет, советует использовать ключ -t

ssh -t localhost 'tty'
```
13)Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.
```
Провёл тест по описанию из документации (https://github.com/nelhage/reptyr)

в сессии 1 запустил top (получил список процессов)
отправил в фон по ctrl+z, bg

получил pid процесса (1112)

сделал disown top (проверил, что отображается в выводе ps -a)

запустил ещё одну сессию ssh, выполнил reptyr 1112

получил таблицу top во второй сессии 


при первой попытке запуска reptyr получил ошибку: 

Unable to attach to pid 1780: Operation not permitted
The kernel denied permission while attaching. If your uid matches
the target's, check the value of /proc/sys/kernel/yama/ptrace_scope.
For more information, see /etc/sysctl.d/10-ptrace.conf

Выставил значение (по инструкции из интернета): kernel.yama.ptrace_scope = 0
```
14) sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.
```
tee - команда, принимает данные на вход с одного источника и может выводить на несколько

В данном случае, команда выполняется с повышенными правами и выводит данные в два источника:
в stdout и в указанный файл (new_file) 
```

 # 3.3. Операционные системы, лекция 1
 
 1) Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd.
```
системный вызов команды "cd" (change directory) - chdir("/tmp") 
```
2) Попробуйте использовать команду file на объекты разных типов на файловой системе. Например:
vagrant@netology1:~$ file /dev/tty
 
/dev/tty: character special (5/0)
 
vagrant@netology1:~$ file /dev/sda
 
/dev/sda: block special (8/0)
 
vagrant@netology1:~$ file /bin/bash
 
/bin/bash: ELF 64-bit LSB shared object, x86-64

Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.
```
Файл распологается тут: /usr/share/misc/magic.mgc
```
3) Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
```
не уверен, что правильно понял задание. я должен узнать PID удалённого файла, а после перенаправить его:

echo '' >/proc/PID_ФАИЛА/fd/3
```
4) Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?
```
Нет, не занимают ресурсы системы, но записываются в таблице процессов.
```
5) В iovisor BCC есть утилита opensnoop:
root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04. Дополнительные сведения по установке.
```
(для запуска команды выше требуются повышенные права)

PID    COMM               FD ERR PATH
823    vminfo              4   0 /var/run/utmp
590    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
590    dbus-daemon        16   0 /usr/share/dbus-1/system-services
590    dbus-daemon        -1   2 /lib/dbus-1/system-services
590    dbus-daemon        16   0 /var/lib/snapd/dbus-1/system-services/
595    irqbalance          6   0 /proc/interrupts
595    irqbalance          6   0 /proc/stat
```
6) Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.
```
Системный вызов uname

Циатата (uname(2)):

Part of the utsname information is also accessible  via  /proc/sys/ker‐
       nel/{ostype, hostname, osrelease, version, domainname}.
```
7) Чем отличается последовательность команд через ; и через && в bash? Например:
```
root@netology1:~# test -d /tmp/some_dir; echo Hi
Hi
root@netology1:~# test -d /tmp/some_dir && echo Hi
root@netology1:~#

; - разделитель последовательных команд
&& - оператор AND, следующая команда запустится только при успешном выполнении предыдущей
```
Есть ли смысл использовать в bash &&, если применить set -e?
```
в первом примере (root@netology1:~# test -d /tmp/some_dir; echo Hi) echo выполнит вывод на экран Hi в любом случае
во втором (test -d /tmp/some_dir && echo Hi) - команда echo отработает только при условии успешного выполнения первой команды

&& и set -e по сути делают одно и тоже. set -e прервёт выполнение цепочки команд, если какая-то из них не завершилась успехом. Думаю, смысла применять && в такой ситуации нет. 
```

8) Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?
```
-e прерывает выполнение последовательности при ошибке (получении не нулевого статуса) 
-x вывод команд и их аргументов когда те выполнены 
-u неустановленные/не заданные параметры и переменные считаются как ошибки
-o pipefail вернёт статус последней команды для выхода с не нулевым статусом или ноль, если ни одна команда не вышла с не нулевым статусом.

остановит выполнение последовательности команд при наличие ошибки, упрощает поиск ошибок (увеличивает детализацию)
```

9) Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).
```
vagrant@vagrant:~$ ps -o stat
STAT
Ss
R+

Ss - процесс, ожидающий завершения
R+ - процессы в фоне.

доп. символы - дополнительные характеристики, типа, приоритета и тп. 
```
 
# 3.4. Операционные системы, лекция 2
 
 1) На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

поместите его в автозагрузку,
предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

```
vagrant@vagrant:/etc/systemd/system$ ps -e |grep node_exporter  
  12594 ?        00:00:00 node_exporter
vagrant@vagrant:/etc/systemd/system$ systemctl stop node_exporter
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to stop 'node_exporter.service'.
Authenticating as: vagrant,,, (vagrant)
Password: 
==== AUTHENTICATION COMPLETE ===
vagrant@vagrant:/etc/systemd/system$ ps -e |grep node_exporter  
vagrant@vagrant:/etc/systemd/system$ systemctl start node_exporter
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to start 'node_exporter.service'.
Authenticating as: vagrant,,, (vagrant)
Password: 
==== AUTHENTICATION COMPLETE ===
vagrant@vagrant:/etc/systemd/system$ ps -e |grep node_exporter  
  12707 ?        00:00:00 node_exporter

Сервис:
vagrant@vagrant:/etc/systemd/system$ cat /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=vagrant
Group=vagrant
Type=simple
ExecStart=/usr/local/bin/node_exporter
EnvironmentFile=/etc/default/node_exporter

[Install]
WantedBy=multi-user.target

Переменная окружения
vagrant@vagrant:/etc/default$ sudo cat /proc/12914/environ 
LANG=en_US.UTF-8LANGUAGE=en_US:PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/binHOME=/home/vagrantLOGNAME=vagrantUSER=vagrantSHELL=/bin/bashINVOCATION_ID=2076e5eb3c64480985a09438e92520ebJOURNAL_STREAM=9:41650vagrant@vagrant:/etc/default$ 

(исправления\дополнения)

(при помощи чата и гугла)

указываю в отдельном файле требуемые переменные. добавляю файлик в автозапуск (тогда система грузит доп параметры из файла)

[Service]
EnvironmentFile=-/etc/default/cron
ExecStart=/usr/sbin/cron -f $EXTRA_OPTS


```

2) Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

```
node_cpu_seconds_total{cpu="0",mode="idle"} 3251.81
node_cpu_seconds_total{cpu="0",mode="iowait"} 5.96

node_disk_io_time_seconds_total{device="dm-0"} 54.424
node_disk_io_time_seconds_total{device="dm-1"} 0.46
node_disk_io_time_seconds_total{device="sda"} 55.58

node_disk_read_bytes_total{device="dm-0"} 3.5654144e+08
node_disk_read_bytes_total{device="dm-1"} 3.342336e+06
node_disk_read_bytes_total{device="sda"} 3.70340864e+08

node_disk_read_time_seconds_total{device="dm-0"} 44.212
node_disk_read_time_seconds_total{device="dm-1"} 0.452
node_disk_read_time_seconds_total{device="sda"} 29.505

node_memory_MemTotal_bytes 1.028694016e+09

node_network_receive_drop_total{device="eth0"} 0
node_network_receive_drop_total{device="lo"} 0

node_network_receive_errs_total{device="eth0"} 0
node_network_receive_errs_total{device="lo"} 0
```

3) Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:
в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload: config.vm.network "forwarded_port", guest: 19999, host: 19999 
После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. 
Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.
```
vagrant@vagrant:~$ sudo lsof -i :19999
COMMAND PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
netdata 966 netdata    4u  IPv4  24764      0t0  TCP *:19999 (LISTEN)
netdata 966 netdata   20u  IPv4  28980      0t0  TCP vagrant:19999->_gateway:50500 (ESTABLISHED)
netdata 966 netdata   24u  IPv4  29978      0t0  TCP vagrant:19999->_gateway:50499 (ESTABLISHED)
netdata 966 netdata   31u  IPv4  29980      0t0  TCP vagrant:19999->_gateway:50501 (ESTABLISHED)
netdata 966 netdata   38u  IPv4  28982      0t0  TCP vagrant:19999->_gateway:50505 (ESTABLISHED)
netdata 966 netdata   51u  IPv4  28984      0t0  TCP vagrant:19999->_gateway:50506 (ESTABLISHED)
netdata 966 netdata   52u  IPv4  28986      0t0  TCP vagrant:19999->_gateway:50511 (ESTABLISHED)

(добавлен скриншот)

```

4) Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

```
Да, система сообщает что виртуализована

vagrant@vagrant:~$ dmesg |grep virt
[    0.004281] CPU MTRRs all blank - virtualized system.
[    0.141868] Booting paravirtualized kernel on KVM
[    3.307809] systemd[1]: Detected virtualization oracle.
```

5)Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

```
vagrant@vagrant:~$ sysctl -n fs.nr_open
1048576
Лимит на максимальное количество открытых дискрипторов (ulimit -n)
```

6) Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.
```
(исправлено)

терминал 1
vagrant@vagrant:~$ sudo -i unshare -f --pid --mount-proc sleep 1h

Терминал 2
vagrant@vagrant:~$ ps -e |grep sleep
2267 pts/0    00:00:00 sleep
root@vagrant:/# nsenter --target 2267 --mount --pid ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   8076   592 pts/0    S+   09:51   0:00 sleep 1h
root           3  0.0  0.3  11492  3384 pts/1    R+   09:53   0:00 ps aux
```
7) Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

```
"В действительности эта команда является логической бомбой. Она оперирует определением функции с именем ‘:‘, которая вызывает сама себя дважды: один раз на переднем плане и один раз в фоне. Она продолжает своё выполнение снова и снова, пока система не зависнет." (c)

(исправления\дополнения)

Существует ограничение на количество процессов одного пользователя, судя по всему, при привышении лимита контроллер заблокировал выполнение команды (не дал создать больше процессов)

dmesg выводит:
[ 1292.599507] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope
[ 1308.267364] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-5.scope

исходя из этого, можно установить(снизить) лимит для пользователя командой ulimit -u (либо, добавлением в файл конфигурации, для работы на постоянной основе)

```
 
 
# 3.5. Файловые системы

1) Узнайте о sparse (разряженных) файлах.

```
Сделано
```

2) Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

```
Нет, жёсткая ссылка является копией идентификатора файла (inote).

потестил, создав файлик и хардлинк к нему:

vagrant@vagrant:~$ mcedit test-1
vagrant@vagrant:~$ stat --format=%h test-1
1
vagrant@vagrant:~$ ln test-1 test-1_hardlink
vagrant@vagrant:~$ stat --format=%h test-1
2
vagrant@vagrant:~$ stat --format=%i test-1; stat --format=%i test-1_hardlink
131102
131102
vagrant@vagrant:~$ ls -ilh
total 16K
131098 -rw-r--r-- 1 root    root    1.3K Dec  5  2002 jcameron-key.asc
131102 -rw-rw-r-- 2 vagrant vagrant   11 Nov 29 17:52 test-1
131102 -rw-rw-r-- 2 vagrant vagrant   11 Nov 29 17:52 test-1_hardlink
131097 drwxrwxrwx 2 root    root    4.0K Nov 28 18:49 vm
vagrant@vagrant:~$ chmod 0754 test-1_hardlink
vagrant@vagrant:~$ ls -ilh
total 16K
131098 -rw-r--r-- 1 root    root    1.3K Dec  5  2002 jcameron-key.asc
131102 -rwxr-xr-- 2 vagrant vagrant   11 Nov 29 17:52 test-1
131102 -rwxr-xr-- 2 vagrant vagrant   11 Nov 29 17:52 test-1_hardlink
131097 drwxrwxrwx 2 root    root    4.0K Nov 28 18:49 vm
vagrant@vagrant:~$

```

3) Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provider :virtualbox do |vb|
    lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
    lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
    vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
    vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path] 
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path] 
  end
 
end
 
```
сделано

vagrant@vagrant:~$ lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm  /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm  [SWAP]
sdb                    8:16   0  2.5G  0 disk
sdc                    8:32   0  2.5G  0 disk

```

4) Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.
```
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
└─sdb2                 8:18   0  500M  0 part
```

5) Используя sfdisk, перенесите данную таблицу разделов на второй диск.

```
vagrant@vagrant:~$ sudo -i
root@vagrant:~# sfdisk -d /dev/sdb|sfdisk --force /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new GPT disklabel (GUID: CE8B8612-8CBF-3A41-8655-F8A6B2B62B50).
/dev/sdc1: Created a new partition 1 of type 'Linux filesystem' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux filesystem' and of size 500 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: gpt
Disk identifier: CE8B8612-8CBF-3A41-8655-F8A6B2B62B50

Device       Start     End Sectors  Size Type
/dev/sdc1     2048 4196351 4194304    2G Linux filesystem
/dev/sdc2  4196353 5220351 1023999  500M Linux filesystem

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

```
vagrant@vagrant:~$ lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm  /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm  [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
└─sdb2                 8:18   0  500M  0 part
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
└─sdc2                 8:34   0  500M  0 part
```

6) Соберите mdadm RAID1 на паре разделов 2 Гб.
```
vagrant@vagrant:~$ sudo -i
root@vagrant:~# mdadm --create --verbose /dev/md1 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
root@vagrant:~# lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md1                9:1    0    2G  0 raid1
└─sdb2                 8:18   0  500M  0 part
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md1                9:1    0    2G  0 raid1
└─sdc2                 8:34   0  500M  0 part
```

7) Соберите mdadm RAID0 на второй паре маленьких разделов.

```
root@vagrant:~# mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
root@vagrant:~# lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md1                9:1    0    2G  0 raid1
└─sdb2                 8:18   0  500M  0 part
  └─md0                9:0    0  995M  0 raid0
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md1                9:1    0    2G  0 raid1
└─sdc2                 8:34   0  500M  0 part
  └─md0                9:0    0  995M  0 raid0
```

8) Создайте 2 независимых PV на получившихся md-устройствах.
```
root@vagrant:~# pvcreate /dev/md1 /dev/md0
  Physical volume "/dev/md1" successfully created.
  Physical volume "/dev/md0" successfully created.
  
root@vagrant:~# pvs
  PV         VG        Fmt  Attr PSize   PFree
  /dev/md0             lvm2 ---  995.00m 995.00m
  /dev/md1             lvm2 ---   <2.00g  <2.00g
  /dev/sda5  vgvagrant lvm2 a--  <63.50g      0
```

9) Создайте общую volume-group на этих двух PV.

```
root@vagrant:~# vgcreate test_vg /dev/md1 /dev/md0
  Volume group "test_vg" successfully created
root@vagrant:~# vgs
  VG        #PV #LV #SN Attr   VSize   VFree
  test_vg     2   0   0 wz--n-   2.96g 2.96g
  vgvagrant   1   2   0 wz--n- <63.50g    0
```

10) Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

```
root@vagrant:~# lvcreate -L 100Mb -n test_lv /dev/test_vg /dev/md0
  Logical volume "test_lv" created.
  
root@vagrant:~# lvs
  LV      VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  test_lv test_vg   -wi-a----- 100.00m
  root    vgvagrant -wi-ao---- <62.54g
  swap_1  vgvagrant -wi-ao---- 980.00m
```

11) Создайте mkfs.ext4 ФС на получившемся LV.

```
root@vagrant:~# mkfs.ext4 /dev/test_vg/test_lv
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```

12) Смонтируйте этот раздел в любую директорию, например, /tmp/new.

```
root@vagrant:~# mkdir /tmp/new
root@vagrant:~# mount /dev/test_vg/test_lv /tmp/new
```

13) Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

```
сделано (командой из вопроса)

root@vagrant:~# ls -l /tmp/new
total 22064
drwx------ 2 root root    16384 Nov 29 19:15 lost+found
-rw-r--r-- 1 root root 22574425 Nov 29 09:55 test.gz
```

14) Прикрепите вывод lsblk

```
root@vagrant:~# lsblk
NAME                  MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                     8:0    0   64G  0 disk
├─sda1                  8:1    0  512M  0 part  /boot/efi
├─sda2                  8:2    0    1K  0 part
└─sda5                  8:5    0 63.5G  0 part
  ├─vgvagrant-root    253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1  253:1    0  980M  0 lvm   [SWAP]
sdb                     8:16   0  2.5G  0 disk
├─sdb1                  8:17   0    2G  0 part
│ └─md1                 9:1    0    2G  0 raid1
└─sdb2                  8:18   0  500M  0 part
  └─md0                 9:0    0  995M  0 raid0
    └─test_vg-test_lv 253:2    0  100M  0 lvm   /tmp/new
sdc                     8:32   0  2.5G  0 disk
├─sdc1                  8:33   0    2G  0 part
│ └─md1                 9:1    0    2G  0 raid1
└─sdc2                  8:34   0  500M  0 part
  └─md0                 9:0    0  995M  0 raid0
    └─test_vg-test_lv 253:2    0  100M  0 lvm   /tmp/new
```

15) Протестируйте целостность файла:

root@vagrant:~# gzip -t /tmp/new/test.gz
                                       
root@vagrant:~# echo $?
                                       
0

```
root@vagrant:~# gzip -t /tmp/new/test.gz ; echo $?
0
```

16) Используя pvmove, переместите содержимое PV с RAID0 на RAID1

```
root@vagrant:~# pvmove /dev/md0 /dev/md1
  /dev/md0: Moved: 20.00%
  /dev/md0: Moved: 100.00%
```

17) Сделайте --fail на устройство в вашем RAID1 md.

```
root@vagrant:~# mdadm /dev/md1 --fail /dev/sdc1
mdadm: set /dev/sdc1 faulty in /dev/md1
```

18) Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

```
root@vagrant:~# dmesg | grep md1
[ 2708.736636] md/raid1:md1: not clean -- starting background reconstruction
[ 2708.736638] md/raid1:md1: active with 2 out of 2 mirrors
[ 2708.736658] md1: detected capacity change from 0 to 2144337920
[ 2708.739726] md: resync of RAID array md1
[ 2719.088768] md: md1: resync done.
[ 5396.689175] md/raid1:md1: Disk failure on sdc1, disabling device.
               md/raid1:md1: Operation continuing on 1 devices.
```

19) Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

root@vagrant:~# gzip -t /tmp/new/test.gz
                                       
root@vagrant:~# echo $?
                                       
0

```
root@vagrant:~# gzip -t /tmp/new/test.gz ; echo $?
0
```

20) Погасите тестовый хост, vagrant destroy.

```
Сделано
```

                                       
# 3.6. Компьютерные сети, лекция 1

1) Работа c HTTP через телнет.

Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
отправьте HTTP запрос:
                                       
GET /questions HTTP/1.0
                                       
HOST: stackoverflow.com
                                       
[press enter]
                                       
[press enter]

В ответе укажите полученный HTTP код, что он означает?

```
(исправлено)
vagrant@vagrant:~$ telnet stackoverflow.com 80
Trying 151.101.1.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
x-request-guid: 759f313c-c3ed-4e7e-805e-24699eb9485e
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Fri, 03 Dec 2021 16:54:11 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-fra19182-FRA
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1638550452.906272,VS0,VE92
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=8ef4aea3-5335-599f-11fc-224a603ec320; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

Connection closed by foreign host.


Ошибка 301, перенаправление. Говорит о том, что адрес утратил актуальность (был, на постоянной, основе перемещён). 
```

2) Повторите задание 1 в браузере, используя консоль разработчика F12.

- откройте вкладку Network
- отправьте запрос http://stackoverflow.com
- найдите первый ответ HTTP сервера, откройте вкладку Headers
- укажите в ответе полученный HTTP код.
- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
- приложите скриншот консоли браузера в ответ.

```
- найдите первый ответ HTTP сервера, откройте вкладку Headers
- укажите в ответе полученный HTTP код.

Request URL: https://stackoverflow.com/
Request Method: GET
Status Code: 200 
Remote Address: 151.101.65.69:443
Referrer Policy: strict-origin-when-cross-origin

- проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?

Скачивание страницы (185.08 ms). TTFB (142.35 ms) . Т.е. дольше всего ожидалось получение первого байта и загрузка страницы.

(добавлен скриншот) 

```

3) Какой IP адрес у вас в интернете?

```
79.165.75.79
```

4) Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

```
netname:        Neo-CNT
origin:         AS8615
```


5) Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute

```
vagrant@vagrant:~$ traceroute -IAn 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  10.0.2.2 [*]  0.089 ms  0.070 ms  0.102 ms
 2  192.168.1.1 [*]  0.946 ms  0.925 ms  0.841 ms
 3  10.185.64.1 [*]  4.128 ms  4.384 ms  4.478 ms
 4  213.85.208.254 [AS8615]  4.428 ms  4.505 ms  4.754 ms
 5  188.254.54.237 [AS12389]  4.692 ms  5.146 ms  5.626 ms
 6  72.14.205.132 [AS15169]  5.564 ms  5.273 ms  5.245 ms
 7  216.239.49.17 [AS15169]  5.054 ms  4.633 ms  4.691 ms
 8  108.170.250.83 [AS15169]  4.036 ms * *
 9  209.85.249.158 [AS15169]  22.687 ms  22.933 ms *
10  74.125.253.94 [AS15169]  19.549 ms  19.894 ms  19.883 ms
11  216.239.62.107 [AS15169]  20.339 ms  19.542 ms  19.510 ms
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  8.8.8.8 [AS15169]  21.831 ms  21.612 ms  19.901 ms
```


6) Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?

```
                                                 My traceroute  [v0.93]
vagrant (10.0.2.15)                                                                            2021-12-02T12:08:06+0000
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                                               Packets               Pings
 Host                                                                        Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. _gateway                                                                  0.0%   446    0.2   6.9   0.1 181.2  28.9
 2. router.asus.com                                                           0.0%   446    1.5   0.8   0.6   6.7   0.4
 3. 10.185.64.1                                                               0.0%   446    3.9   4.1   3.0  82.8   5.4
 4. 213.85.208.254                                                            0.0%   446    4.4   4.8   3.8  23.9   2.1
 5. 188.254.54.237                                                            0.0%   446    4.5   6.0   4.1  32.9   3.5
 6. 72.14.205.132                                                             0.0%   446    4.9   4.9   4.6   8.9   0.5
 7. 216.239.49.17                                                             0.0%   446    4.8   4.6   4.4  12.8   0.6
 8. 108.170.250.83                                                           14.1%   446   17.9   6.0   4.0  60.8   5.8
 9. 209.85.249.158                                                           55.5%   446   24.7  23.0  21.5  80.0   5.3
10. 74.125.253.94                                                             0.0%   446   19.5  22.7  19.3  82.2   8.4
11. 216.239.62.107                                                            0.0%   446   19.6  20.3  19.3  64.6   2.8
12. (waiting for reply)
13. (waiting for reply)
14. (waiting for reply)
15. (waiting for reply)
16. (waiting for reply)
17. (waiting for reply)
18. (waiting for reply)
19. (waiting for reply)
20. (waiting for reply)
21. dns.google                                                               24.9%   445   19.2  20.5  18.1  43.4   1.6

Наибольшая задержка у 9-го хоста (он же больше всех теряет пакетов)
```

7) Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig

```
DNS:
vagrant@vagrant:~$ dig dns.google +noall +answer
dns.google.             158     IN      A       8.8.4.4
dns.google.             158     IN      A       8.8.8.8

```

8) Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig
В качестве ответов на вопросы можно приложите лог выполнения команд в консоли или скриншот полученных результатов.

```
vagrant@vagrant:~$ dig -x 8.8.8.8 +noall +answer
8.8.8.8.in-addr.arpa.   4188    IN      PTR     dns.google.

vagrant@vagrant:~$ dig -x 8.8.4.4 +noall +answer
4.4.8.8.in-addr.arpa.   20327   IN      PTR     dns.google.
```
