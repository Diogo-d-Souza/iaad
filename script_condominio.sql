-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema condominio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema condominio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `condominio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `condominio` ;

-- -----------------------------------------------------
-- Table `condominio`.`administradora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`administradora` (
  `CNPJ` INT NOT NULL,
  `Nome` VARCHAR(30) NULL DEFAULT NULL,
  `Endereço` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`pessoa` (
  `CPF` INT NOT NULL,
  `Nome` VARCHAR(30) NULL DEFAULT NULL,
  `Genero` VARCHAR(1) NULL DEFAULT NULL,
  `Data_nascimento` DATE NULL DEFAULT NULL,
  `Telefone` INT NULL DEFAULT NULL,
  `Email` VARCHAR(30) NULL DEFAULT NULL,
  `Profissão` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`morador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`morador` (
  `Cod_Apartamento` INT NOT NULL,
  `Cod_Edificio` INT NOT NULL,
  `CPF_Morador` INT NOT NULL,
  PRIMARY KEY (`Cod_Apartamento`, `Cod_Edificio`, `CPF_Morador`),
  INDEX `Cod_Edificio` (`Cod_Edificio` ASC) VISIBLE,
  INDEX `CPF_Morador` (`CPF_Morador` ASC) VISIBLE,
  CONSTRAINT `morador_ibfk_1`
    FOREIGN KEY (`Cod_Apartamento`)
    REFERENCES `condominio`.`apartamento` (`Cod_Apartamento`),
  CONSTRAINT `morador_ibfk_2`
    FOREIGN KEY (`Cod_Edificio`)
    REFERENCES `condominio`.`edificio` (`Cod_Edificio`),
  CONSTRAINT `morador_ibfk_3`
    FOREIGN KEY (`CPF_Morador`)
    REFERENCES `condominio`.`pessoa` (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`edificio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`edificio` (
  `Cod_Edificio` INT NOT NULL,
  `Nome` VARCHAR(30) NULL DEFAULT NULL,
  `Endereço` VARCHAR(30) NULL DEFAULT NULL,
  `CPF_Sindico` INT NOT NULL,
  `CNPJ_Admin` INT NOT NULL,
  PRIMARY KEY (`Cod_Edificio`),
  UNIQUE INDEX `CPF_Sindico` (`CPF_Sindico` ASC) VISIBLE,
  INDEX `CNPJ_Admin` (`CNPJ_Admin` ASC) VISIBLE,
  CONSTRAINT `cpfsindico`
    FOREIGN KEY (`CPF_Sindico`)
    REFERENCES `condominio`.`morador` (`CPF_Morador`),
  CONSTRAINT `edificio_ibfk_1`
    FOREIGN KEY (`CNPJ_Admin`)
    REFERENCES `condominio`.`administradora` (`CNPJ`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`apartamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`apartamento` (
  `Cod_Apartamento` INT NOT NULL,
  `Cod_Edificio` INT NOT NULL,
  `CPF_Proprietario` INT NOT NULL,
  `Número_Apt` INT NOT NULL,
  `Qtd_Quartos` INT NOT NULL,
  `Qtd_Banheiros` INT NOT NULL,
  PRIMARY KEY (`Cod_Apartamento`, `Cod_Edificio`),
  INDEX `Cod_Edificio` (`Cod_Edificio` ASC) VISIBLE,
  INDEX `CPF_Proprietario` (`CPF_Proprietario` ASC) VISIBLE,
  CONSTRAINT `apartamento_ibfk_1`
    FOREIGN KEY (`Cod_Edificio`)
    REFERENCES `condominio`.`edificio` (`Cod_Edificio`),
  CONSTRAINT `apartamento_ibfk_2`
    FOREIGN KEY (`CPF_Proprietario`)
    REFERENCES `condominio`.`pessoa` (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`funcionario` (
  `CPF_Funcionario` INT NOT NULL,
  `Cod_Edificio` INT NOT NULL,
  `Data_Admissão` DATE NULL DEFAULT NULL,
  `CargoFunção` VARCHAR(20) NULL DEFAULT NULL,
  `Salário` INT NOT NULL,
  PRIMARY KEY (`CPF_Funcionario`, `Cod_Edificio`),
  INDEX `Cod_Edificio` (`Cod_Edificio` ASC) VISIBLE,
  CONSTRAINT `funcionario_ibfk_1`
    FOREIGN KEY (`CPF_Funcionario`)
    REFERENCES `condominio`.`pessoa` (`CPF`),
  CONSTRAINT `funcionario_ibfk_2`
    FOREIGN KEY (`Cod_Edificio`)
    REFERENCES `condominio`.`edificio` (`Cod_Edificio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
