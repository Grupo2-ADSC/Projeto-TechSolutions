var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucao = `
        SELECT id, nome, email, fk_empresa as empresaId FROM usuario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucao
async function cadastrar(cnpj, nome, telefone, email, senha, cep, logradouro, numero, complemento, bairro, cidade,
    estado) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", cnpj, nome, telefone, email, senha, cep, logradouro, numero, complemento, bairro, cidade,
        estado);


    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.

    var instrucao2 = `
        INSERT INTO endereco (cep, logradouro, numero, complemento, bairro, cidade,
            estado, tipo) VALUES ('${cep}', '${logradouro}', '${numero}', '${complemento}', '${bairro}', '${cidade}', '${estado}', 'Empresa');
    `;

    await database.executar(instrucao2);

    var idEndereco = await database.executar(`SELECT idEndereco FROM endereco WHERE cep = '${cep}' AND logradouro = '${logradouro}' AND numero = '${numero}'`);

    if (idEndereco.length > 0) {
        // Certifique-se de que você está obtendo um valor válido antes de prosseguir
        var idEnderecoValor = idEndereco[0].idEndereco;

        // Inserção na tabela empresa
        var instrucao = `
             INSERT INTO empresa (cnpj, nome, telefone, email, senha, fkEndereco) VALUES ('${cnpj}', '${nome}', '${telefone}', '${email}', '${senha}', ${idEnderecoValor});
         `;

        console.log("Executando a instrução SQL: \n" + instrucao);
        return database.executar(instrucao);
    } else {
        // Tratar caso não encontre um ID de endereço válido
        console.error("Erro: Não foi possível obter um ID de endereço válido.");
        return Promise.reject("Erro: Não foi possível obter um ID de endereço válido.");
    }

}

module.exports = {
    autenticar,
    cadastrar
};