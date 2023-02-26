# projeto_carloca_sinqia
Projeto criado para conclusão do módulo de SQL do curso dev_makers - Ada e Sinqia
## Como executar:
Ao se criar um novo contrato de aluguel na tabela "aluguel", o banco irá verificar se o cliente informado e/ou o carro informado estão com status "disponível". Caso estejam, o aluguel será criado. Caso esteja "indisponível", retornará uma mensagem de erro dizendo que "o carro e/ou o cliente estão indisponíveis". Todo novo contrato deve ser criado com status "ativo". Após a criação, é disparado um trigger que alterar o status do carro e do cliente para "indisponível".
Para finalizar um aluguel, o usuário deve informar a quilometragem rodada e a data e hora da devolução. No final, alterar o status para "inativo"
Ao alterar o "status_aluguel" da tabela "aluguel" para "inativo", dispara uma trigger que reseta o cliente e o carro para "disponivel" e soma a quilometragem rodada com a quilometragem do carro, além de criar um dado da tabela de consulta "histórico_alugueis" com o id do cliente da locação, o id do carro e a quilometragem da locação.
Todo contrato, mesmo que inativo, continua na base. O que permite um cliente alugar outro carro após o fim de uma locação é a automação realizada pela trigger, que torna o cliente e o carro disponíveis novamente.
