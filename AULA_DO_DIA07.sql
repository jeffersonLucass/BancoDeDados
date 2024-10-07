-- inserção de dados
select * from jogo;

-- tabela jogo
insert into jogo(nomeJogo)
VALUES('The Legend of Zelda'); -- 1
insert into jogo(nomeJogo) values
('Game B'), -- 2
('Game C'); -- 3

-- tabela plataforma

insert into plataforma (nomePlataforma) values
("Playstation"), -- 1
("Xbox"), -- 2
("PC"); -- 3

select * from plataforma;

-- tabela jogo_plataforma

insert into jogo_plataforma(Jogo_idJogo,Plataforma_idPlataforma,precoPlataforma) values
(1,1,30.00), (1,2,40.00), (1,3,50.00),
(2,1,20.00), (2,2,35.00),
(3,3,25.00);

select * from jogo_plataforma;

-- select para visualizar os dados entre jogo e plataforma

select
	j.nomeJogo as Nome,
    p.nomePlataforma as Plataforma,
    jp.precoPlataforma as Preço
from jogo j
inner join jogo_plataforma jp on j.idJogo = jp.Jogo_idJogo
inner join plataforma p on jp.Plataforma_idPlataforma = p.idPlataforma;

-- agregação  

select count(*) as qtd
from plataforma;

select
	p.nomePlataforma,
    count(jp.Jogo_idJogo) as qtd_jogos
from plataforma p
inner join jogo_plataforma jp on p.idPlataforma = jp.Plataforma_idPlataforma
group by p.nomePlataforma;


-- Valor total dos jogos;
select sum(jp.precoPlataforma) as soma_total
from jogo_plataforma jp;

-- Media dos preços dos jogos;

select avg(jp.precoPlataforma) as media_dos_Jogos
from jogo_plataforma jp;


-- jogo mais caro

select
	j.nomeJogo as Nome,
    p.nomePlataforma as Plataforma,
    jp.precoPlataforma As Preço
from
	jogo j
INNER JOIN 
    jogo_plataforma jp ON j.idJogo = jp.Jogo_idJogo
INNER JOIN 
    plataforma p ON jp.Plataforma_idPlataforma = p.idPlataforma
WHERE 
    jp.precoPlataforma = (
        SELECT MAX(precoPlataforma) 
        FROM jogo_plataforma
);
    
-- jogo mais barato

select
	j.nomeJogo as Nome,
    p.nomePlataforma as Plataforma,
    jp.precoPlataforma As Preço
from
	jogo j
INNER JOIN 
    jogo_plataforma jp ON j.idJogo = jp.Jogo_idJogo
INNER JOIN 
    plataforma p ON jp.Plataforma_idPlataforma = p.idPlataforma
WHERE 
    jp.precoPlataforma = (
        SELECT min(precoPlataforma) 
        FROM jogo_plataforma
);
    
-- Plataforma que termina com "n";
SELECT nomePlataforma
FROM plataforma
WHERE nomePlataforma LIKE '%n';

-- plataforma que possuem mais jogos

 SELECT p.nomePlataforma
FROM plataforma p
INNER JOIN jogo_plataforma jp ON p.idPlataforma = jp.Plataforma_idPlataforma
GROUP BY p.nomePlataforma
HAVING COUNT(jp.Jogo_idJogo) > 1;
   

SELECT CASE 
    WHEN EXISTS (
        SELECT 1
        FROM jogo_plataforma
        WHERE precoPlataforma < 25
    ) THEN 'Sim, existe pelo menos um jogo com valor menor que 25.'
    ELSE 'Não, não existem jogos com valor menor que 25.'
END AS resultado;


SELECT CASE 
    WHEN NOT EXISTS (
        SELECT 1
        FROM jogo_plataforma
        WHERE precoPlataforma >= 60
    ) THEN 'Sim, todos os jogos custam menos que 60.'
    ELSE 'Não, existem jogos que custam 60 ou mais.'
END AS resultado;






