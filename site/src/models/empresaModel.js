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
function cadastrar(cnpj, nome, telefone, email, senha, cep, logradouro, numero, complemento, bairro, cidade,
    estado) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", cnpj, nome, telefone, email, senha, cep, logradouro, numero, complemento, bairro, cidade,
    estado);
    
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.

     var instrucao2 = `
        INSERT INTO endereco (cep, logradouro, numero, complemento, bairro, cidade,
            estado, tipo) VALUES ('${cep}', '${logradouro}', '${numero}', '${complemento}', '${bairro}', '${cidade}', '${estado}', 'Empresa');
    `;

    database.executar(instrucao2);

    var idEndereco = database.executar(`select idEndereco from endereco where cep = '${cep}' and logradouro = '${logradouro}' and numero = '${numero}'`);
    console.log(idEndereco);

    var instrucao = `
        INSERT INTO empresa (cnpj, nome, telefone, email, senha, fkEndereco) VALUES ('${cnpj}', '${nome}', '${telefone}', '${email}', '${senha}', '${idEndereco}');
    `;

   
    console.log("Executando a instrução SQL: \n" + instrucao2);
    return database.executar(instrucao2),
    database.executar(instrucao);

}

module.exports = {
    autenticar,
    cadastrar
};