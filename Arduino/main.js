const serialport = require('serialport');
const express = require('express');
const mysql = require('mysql2');

const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 3000;
const HABILITAR_OPERACAO_INSERIR = true; /*Sempre verdadeiro*/

const serial = async (
    valoresDht11Umidade
) => {
    const poolBancoDados = mysql.createPool(
        {
            host: 'localhost', /*local do SQL*/

            port: 3306,  /* a porta de entrada do usb, entre no cmd do pc para ativar, "netstat -ano", pegue o PID ex:"12567" e faça "taskkill /PID 12567 -F" obs: veja em qual porta está seu arduino, aparece no git bash quando dá npm start.*/

            user: 'MichellyMendes', /* usuario do SQL*/

            password: 'Urubu100', /*senha do usuario*/

            database: 'TechSolutions' /* database do banco, INSERT INTO sensores (dht11_umidade, dht11_temperatura, luminosidade, lm35_temperatura, chave),*/
        }
    ).promise();

    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);
    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial');
    }
    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );
    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        const valores = data.split(';');
        const dht11Umidade = parseFloat(valores[0]);

        valoresDht11Umidade.push(dht11Umidade);

        console.log(dht11Umidade)

        if (HABILITAR_OPERACAO_INSERIR) {
            await poolBancoDados.execute(
                'INSERT INTO registro (dado, fkSensor) VALUES (?, ?)',
                [dht11Umidade, 1]
            );

            var dht11Umidade2 = dht11Umidade + 5;

            console.log(dht11Umidade2)

            await poolBancoDados.execute(
                'INSERT INTO registro (dado, fkSensor) VALUES (?, ?)',
                [dht11Umidade2, 2]
            );
   
        }

    });
    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`)
    });
}

const servidor = (
    valoresDht11Umidade

) => {
    const app = express();
    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`A API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });
    app.get('/sensores/dht11/umidade', (_, response) => {
        return response.json(valoresDht11Umidade);
    });
}

(async () => {
    const valoresDht11Umidade = [];

    await serial(
        valoresDht11Umidade

    );
    servidor(
        valoresDht11Umidade
    );
})();
