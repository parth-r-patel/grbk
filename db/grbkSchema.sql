-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema grbk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema grbk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `grbk` DEFAULT CHARACTER SET utf8 ;
USE `grbk` ;

-- -----------------------------------------------------
-- Table `grbk`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grbk`.`courses` (
  `courseID` INT NOT NULL AUTO_INCREMENT,
  `courseCode` VARCHAR(10) NULL,
  PRIMARY KEY (`courseID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grbk`.`sections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grbk`.`sections` (
  `sectionID` INT NOT NULL AUTO_INCREMENT,
  `courseID` INT NULL,
  `sectionNum` INT NULL,
  PRIMARY KEY (`sectionID`),
  INDEX `course2_idx` (`courseID` ASC),
  CONSTRAINT `courseSection`
    FOREIGN KEY (`courseID`)
    REFERENCES `grbk`.`courses` (`courseID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grbk`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grbk`.`categories` (
  `categoryID` INT NOT NULL AUTO_INCREMENT,
  `sectionID` INT NULL,
  `name` VARCHAR(45) NULL,
  `weight` INT NULL,
  `isPercentile` BIT(1) NULL,
  PRIMARY KEY (`categoryID`),
  INDEX `categorySetsion_idx` (`sectionID` ASC),
  CONSTRAINT `categorySetsion`
    FOREIGN KEY (`sectionID`)
    REFERENCES `grbk`.`sections` (`sectionID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grbk`.`metadata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grbk`.`metadata` (
  `metaID` INT NOT NULL AUTO_INCREMENT,
  `categoryID` INT NULL,
  `name` VARCHAR(20) NULL,
  `description` LONGTEXT NULL,
  `maxMarks` INT NULL,
  `weight` INT NULL,
  `due` DATE NULL,
  PRIMARY KEY (`metaID`),
  INDEX `metaCategory_idx` (`categoryID` ASC),
  CONSTRAINT `metaCategory`
    FOREIGN KEY (`categoryID`)
    REFERENCES `grbk`.`categories` (`categoryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grbk`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grbk`.`students` (
  `studentID` INT NOT NULL AUTO_INCREMENT,
  `sectionID` INT NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  PRIMARY KEY (`studentID`),
  INDEX `studentSection_idx` (`sectionID` ASC),
  CONSTRAINT `studentSection`
    FOREIGN KEY (`sectionID`)
    REFERENCES `grbk`.`sections` (`sectionID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grbk`.`assessments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grbk`.`assessments` (
  `assessmentID` INT NOT NULL AUTO_INCREMENT,
  `metaID` INT NULL,
  `studentID` INT NULL,
  `score` INT NULL,
  `percentScore` DOUBLE NULL,
  `active` BIT(1) NULL,
  PRIMARY KEY (`assessmentID`),
  INDEX `assessmentMeta_idx` (`metaID` ASC),
  INDEX `assessmentStudent_idx` (`studentID` ASC),
  CONSTRAINT `assessmentMeta`
    FOREIGN KEY (`metaID`)
    REFERENCES `grbk`.`metadata` (`metaID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `assessmentStudent`
    FOREIGN KEY (`studentID`)
    REFERENCES `grbk`.`students` (`studentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
