-- Cria a tabela funcionarios
CREATE TABLE funcionarios (
             cpf        VARCHAR(11)       NOT NULL,
             nome       VARCHAR(255)      NOT NULL);


/*
 * Cria um comentário referente a tabela funcionarios
 * Cria comentários referentes as colunas da tabela funcionarios
 */
COMMENT ON TABLE  funcionarios       IS 'Tabela dos funcionarios';
COMMENT ON COLUMN funcionarios.cpf   IS 'CPF do funcionário';
COMMENT ON COLUMN funcionarios.nome  IS 'Nome do funcionário';


-- Cria a chave primária da tabela funcionarios
ALTER TABLE     funcionarios
ADD CONSTRAINT 	funcionarios_pk
PRIMARY KEY 	(cpf);


-- Criar comentário referente a chave primária da tabela funcionarios
COMMENT ON CONSTRAINT funcionarios_pk ON funcionarios IS 'Defini a coluna cpf da tabela funcionarios como a chave primária (PK) da tabela funcionarios';


-- Criar as restrições de checagem para a tabela funcionarios
ALTER TABLE 	funcionarios
ADD CONSTRAINT 	check_funcionarios_cpf
CHECK 			(cpf ~ '^[0-9]{11}$' AND cpf::numeric > 0);

ALTER TABLE 	funcionarios
ADD CONSTRAINT 	check_funcionarios_nome
CHECK 			(nome ~ '^\w+\s\w+');


-- Criar comentários referentes as restrições da tabela funcionarios
COMMENT ON CONSTRAINT check_funcionarios_cpf   ON funcionarios  IS  'Verifica se a coluna cpf tem os 11 espaços de caracteres sendo utilizados, e que o número seja maior que 0';
COMMENT ON CONSTRAINT check_funcionarios_nome  ON funcionarios  IS  'Verifica se a coluna nome tem pelo um conjunto de caracteres no início, um espaço, e um outro conjunto de caracteres';


-- Cria a tabela alunos
CREATE TABLE alunos (
             matricula                  VARCHAR(9)   NOT NULL,
             nome                       VARCHAR(255) NOT NULL,
             data_de_nascimento         DATE         NOT NULL,
             curso                      VARCHAR(255) NOT NULL,
             turma                      VARCHAR(5)   NOT NULL,
             periodo                    NUMERIC(1)   NOT NULL,
             atividades_complementares  BOOLEAN      NOT NULL);


/* 
 * Cria um comentário referente a tabela alunos
 * Cria comentários referentes as colunas da tabela alunos
 */
COMMENT ON TABLE  alunos                            IS 'Tabela para os alunos';
COMMENT ON COLUMN alunos.matricula                  IS 'Número da matrícula do aluno';
COMMENT ON COLUMN alunos.nome                       IS 'Nome completo do aluno';
COMMENT ON COLUMN alunos.data_de_nascimento         IS 'Data de nascimento do aluno';
COMMENT ON COLUMN alunos.curso                      IS 'Curso que o aluno está fazendo';
COMMENT ON COLUMN alunos.turma                      IS 'Turma atual do aluno';
COMMENT ON COLUMN alunos.periodo                    IS 'Período em que o aluno está no curso';
COMMENT ON COLUMN alunos.atividades_complementares  IS 'Verificar se o aluno está cursando a matéria de atividades complementares ou não';


-- Cria a chave primária da tabela alunos
ALTER TABLE     alunos
ADD CONSTRAINT 	alunos_pk
PRIMARY KEY 	(matricula);


-- Criar comentário referente a chave primária da tabela alunos
COMMENT ON CONSTRAINT alunos_pk ON alunos IS 'Defini a coluna matricula da tabela alunos como a chave primária (PK) da tabela alunos';


-- Criar as restrições de checagem para a tabela alunos
ALTER TABLE 	alunos
ADD CONSTRAINT 	check_alunos_matricula
CHECK 			(matricula ~ '^[0-9]{9}$' AND matricula::numeric > 0);

ALTER TABLE 	alunos
ADD CONSTRAINT 	check_alunos_nome
CHECK 			(nome ~ '^\w+\s\w+');

ALTER TABLE 	alunos
ADD CONSTRAINT 	check_alunos_periodo
CHECK 			(periodo BETWEEN 1 AND 8);


-- Criar comentários referentes as restrições da tabela alunos
COMMENT ON CONSTRAINT check_alunos_matricula  ON alunos  IS  'Verifica se a coluna matricula tem os 9 espaços de caracteres sendo utilizados, e que o número seja maior que 0';
COMMENT ON CONSTRAINT check_alunos_nome       ON alunos  IS  'Verifica se a coluna nome tem pelo um conjunto de caracteres no início, um espaço, e um outro conjunto de caracteres';
COMMENT ON CONSTRAINT check_alunos_periodo    ON alunos  IS  'Verifica se a coluna periodo está preenchida entre 1 e 8';


-- Cria a tabela certificados
CREATE TABLE    certificados (
                certificado_id        NUMERIC(38)    NOT NULL,
                matricula_aluno       VARCHAR(9)     NOT NULL,
                horas_do_certificado  TIME           NOT NULL,
                arquivo_certificado   BYTEA          NOT NULL,
                status_certificado    VARCHAR        NOT NULL,
                tipo_certificado      VARCHAR        NOT NULL,
                descricao             VARCHAR(510),
                data_envio            TIMESTAMP      NOT NULL,
                cpf_funcionario       VARCHAR(11)    NOT NULL);


/*
 * Cria um comentário referente a tabela certificados
 * Cria comentários referentes as colunas da tabela certificados
 */
COMMENT ON TABLE  certificados                       IS 'Tabela com os certificados';
COMMENT ON COLUMN certificados.certificado_id        IS 'Número do id do certificado';
COMMENT ON COLUMN certificados.matricula_aluno       IS 'Número da matrícula do aluno';
COMMENT ON COLUMN certificados.horas_do_certificado  IS 'Quantidade de horas de um certificado';
COMMENT ON COLUMN certificados.arquivo_certificado   IS 'Imagem do certificado';
COMMENT ON COLUMN certificados.status_certificado    IS 'Status de validação do certificado';
COMMENT ON COLUMN certificados.tipo_certificado      IS 'Tipo de certificado';
COMMENT ON COLUMN certificados.descricao             IS 'Descrição do certificado';
COMMENT ON COLUMN certificados.data_envio            IS 'Data de envio do certificado';
COMMENT ON COLUMN certificados.cpf_funcionario       IS 'CPF do funcionário';


-- Cria a chave primária da tabela certificados
ALTER TABLE     certificados
ADD CONSTRAINT 	certificados_pk
PRIMARY KEY 	(certificado_id);


-- Criar comentário referente a chave primária da tabela certificados
COMMENT ON CONSTRAINT certificados_pk ON certificados IS 'Defini a coluna certificado_id da tabela certificados como a chave primária (PK) da tabela certificados';


-- Criar as relações referentes a tabela certificados
ALTER TABLE      certificados 
ADD CONSTRAINT   funcionarios_certificados_fk
FOREIGN KEY      (cpf_funcionario)
REFERENCES       funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE      certificados 
ADD CONSTRAINT   alunos_certificados_fk
FOREIGN KEY      (matricula_aluno)
REFERENCES       alunos (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Criar comentários referentes as relações da tabela certificados
COMMENT ON CONSTRAINT funcionarios_certificados_fk   ON certificados  IS  'Defini a coluna cpf_funcionario da tabela certificados como uma chave estrangeira (FK) da coluna cpf da tabela funcionarios';
COMMENT ON CONSTRAINT alunos_certificados_fk         ON certificados  IS  'Defini a coluna matricula_aluno da tabela certificados como uma chave estrangeira (FK) da coluna matricula da tabela alunos';


-- Criar as restrições de checagem para a tabela certificados
ALTER TABLE 	certificados
ADD CONSTRAINT 	check_certificados_certificado_id
CHECK 			(certificado_id > 0);

ALTER TABLE 	certificados
ADD CONSTRAINT 	check_certificados_status_certificado
CHECK 			(status_certificado IN ('VÁLIDO','INVÁLIDO','EM ESPERA'));


-- Criar comentários referentes as restrições da tabela certificados
COMMENT ON CONSTRAINT check_certificados_certificado_id      ON certificados  IS  'Verifica se a coluna certificado_id tem um número maior que 0';
COMMENT ON CONSTRAINT check_certificados_status_certificado  ON certificados  IS  'Defini apenas 3 valores válidos para a coluna status_certificado';