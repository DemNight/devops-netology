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
vagrant@vagrant:~$ sudo su
root@vagrant:/home/vagrant# ps -e |grep sleep
   1642 pts/0    00:00:00 sleep
   1643 pts/0    00:00:00 sleep
root@vagrant:/home/vagrant# nsenter --target 1643 --pid --mount
root@vagrant:/# ps
    PID TTY          TIME CMD
   1703 pts/1    00:00:00 sudo
   1705 pts/1    00:00:00 su
   1706 pts/1    00:00:00 bash
   1956 pts/1    00:00:00 nsenter
   1957 pts/1    00:00:00 bash
   1966 pts/1    00:00:00 ps
root@vagrant:/# exit
logout
root@vagrant:/home/vagrant# exit
exit
vagrant@vagrant:~$
```
7) Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

```
"В действительности эта команда является логической бомбой.
Она оперирует определением функции с именем ‘:‘, которая вызывает сама себя дважды: один раз на переднем плане и один раз в фоне.
Она продолжает своё выполнение снова и снова, пока система не зависнет." (c)
```
