# Planney
## Getting Started
É necessário fazer a configuração do Firebase para rodar o projeto.
Por trabalhar com geração de código, após rodar o pub get, deve-se rodar o seguinte comando 
```bash
flutter packages pub run build_runner build
```
Após o comando, caso um arquivo gerado apresente o erro
```bash
error: [dart] The argument type 'Context' can't be assigned to the parameter type 'BuildContext'. [argument_type_not_assignable]
```
Vá aos locais onde o context está sendo chamado e troque por ````dart this.context```
