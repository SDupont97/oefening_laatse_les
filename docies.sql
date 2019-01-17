-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctors` (
  `Name` VARCHAR(255) NOT NULL,
  `Date_of_birth` DATE NULL,
  `Adress` VARCHAR(255) NULL,
  `ID_doctor` INT NOT NULL AUTO_INCREMENT,
  `Phone number` DECIMAL(9) NULL,
  `salary` VARCHAR(50) NULL,
  PRIMARY KEY (`ID_doctor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medical` (
  `idMed` INT NOT NULL AUTO_INCREMENT,
  `Overtime_rate` VARCHAR(45) NOT NULL,
  `Doctors_ID_doctor` INT NOT NULL,
  PRIMARY KEY (`idMed`),
  INDEX `fk_medical_Doctors1_idx` (`Doctors_ID_doctor` ASC) VISIBLE,
  CONSTRAINT `fk_medical_Doctors1`
    FOREIGN KEY (`Doctors_ID_doctor`)
    REFERENCES `mydb`.`Doctors` (`ID_doctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`field of specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`field of specialist` (
  `idspec` INT NOT NULL AUTO_INCREMENT,
  `Fieldofspecialist` ENUM("heart", "gastro", "neuro", "onco", "derma", "pediatrie") NOT NULL,
  `Doctors_ID_doctor` INT NOT NULL,
  PRIMARY KEY (`idspec`),
  INDEX `fk_field of specialist_Doctors_idx` (`Doctors_ID_doctor` ASC) VISIBLE,
  CONSTRAINT `fk_field of specialist_Doctors`
    FOREIGN KEY (`Doctors_ID_doctor`)
    REFERENCES `mydb`.`Doctors` (`ID_doctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `adress` VARCHAR(255) NULL,
  `phone_nr` DECIMAL(9) NULL,
  `Birthdate` DATE NULL,
  PRIMARY KEY (`idPatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `date` DATE NOT NULL,
  `Time` TIME NOT NULL,
  `Patient_idPatient` INT NOT NULL,
  `Doctors_ID_doctor` INT NOT NULL,
  PRIMARY KEY (`idAppointment`),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_idPatient` ASC) VISIBLE,
  INDEX `fk_Appointment_Doctors1_idx` (`Doctors_ID_doctor` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctors1`
    FOREIGN KEY (`Doctors_ID_doctor`)
    REFERENCES `mydb`.`Doctors` (`ID_doctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL,
  `Details` VARCHAR(45) NOT NULL,
  `method` ENUM("Cash", "Card", "kidney") NULL,
  `Patient_idPatient` INT NOT NULL,
  PRIMARY KEY (`idPayment`),
  INDEX `fk_Payment_Patient1_idx` (`Patient_idPatient` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `idBill` INT NOT NULL,
  `total` DECIMAL(50) NOT NULL,
  `Doctors_ID_doctor` INT NOT NULL,
  PRIMARY KEY (`idBill`),
  INDEX `fk_Bill_Doctors1_idx` (`Doctors_ID_doctor` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Doctors1`
    FOREIGN KEY (`Doctors_ID_doctor`)
    REFERENCES `mydb`.`Doctors` (`ID_doctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_has_Bill` (
  `Payment_idPayment` INT NOT NULL,
  `Bill_idBill` INT NOT NULL,
  `billpayID` VARCHAR(45) NOT NULL,
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_idBill` ASC) VISIBLE,
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_idPayment` ASC) VISIBLE,
  PRIMARY KEY (`billpayID`),
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_idBill`)
    REFERENCES `mydb`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
