// grafico 1

const ctx = document.getElementById('myChart').getContext("2d")

const labels =[
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
];

const data ={
    labels: labels,
    datasets: [{
        label: 'Armazem 1',
        backgroundColor: '#004aad',
        borderColor: '#004aad',
        data: [95,66,59,70,25,89], 
    },
    {
        label: 'Armazem 2 ',
        backgroundColor: '#ff914d',
        borderColor: '#ff914d',
        data: [67,55,89,44,66,63],
    }],
};

const config ={
    type: 'line',
    data: data,
    options: {
        responsive: true,
        scales:{
            y:{
                ticks:{
                    callback: function(value){
                        return value + "%"
                    }
                }
            }
        }
    },
};

const myChart = new Chart(ctx, config);


// grafico 2

const ctx2 = document.getElementById('myChart2').getContext("2d")

const labels2 =[
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
];

const umidadeData = [67, 55, 89, 44, 66, 63];

//gradient fill
let gradient = ctx2.createLinearGradient(0,0,0,250);

gradient.addColorStop(1, "rgba(255, 0, 0, 1)"); // Vermelho
gradient.addColorStop(0.2, "rgba(255, 165, 0, 1)"); // Laranja
gradient.addColorStop(0.4, "rgba(255, 255, 0, 1)"); // Amarelo
gradient.addColorStop(0.2, "rgba(0, 128, 0, 1)"); // Verde (menos espaço)
gradient.addColorStop(0.6, "rgba(255, 255, 0, 1)"); // Amarelo
gradient.addColorStop(0.8, "rgba(255, 165, 0, 1)"); // Laranja
gradient.addColorStop(1, "rgba(255, 0, 0, 1)"); // Vermelho


const data2 ={
    labels: labels2,
    datasets: [{
        label: 'Armazem 2 ',
        backgroundColor: gradient,
        borderColor: "rgba(0, 0, 0, 0)",
        data: umidadeData,
        fill: true,
    }],
};

const config2 ={
    type: 'line',
    data: data2,
    options: {
        responsive: true,
        scales:{
            y:{
                ticks:{
                    callback: function(value){
                        return value + "%"
                    }
                }
            }
        }
    },
};

const myChart2 = new Chart(ctx2, config2);


// grafico 3

const myChart3 = new Chart(
    document.getElementById('myChart3'),
    config3
);

