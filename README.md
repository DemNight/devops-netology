# devops-netology

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