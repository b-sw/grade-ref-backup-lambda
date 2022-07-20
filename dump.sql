/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: feature
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `feature` (
  `id` varchar(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `refereeId` varchar(255) NOT NULL,
  `matchId` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_b42e7c54f080f92fe276bd4b82a` (`refereeId`),
  KEY `FK_0e3c9d677cf7f702044e0491259` (`matchId`),
  CONSTRAINT `FK_0e3c9d677cf7f702044e0491259` FOREIGN KEY (`matchId`) REFERENCES `match` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_b42e7c54f080f92fe276bd4b82a` FOREIGN KEY (`refereeId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: foul
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `foul` (
  `id` varchar(36) NOT NULL,
  `minute` int(11) NOT NULL,
  `card` varchar(255) NOT NULL,
  `playerNumber` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `valid` tinyint(4) NOT NULL,
  `teamId` varchar(255) NOT NULL,
  `matchId` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_f96da3ac7e4853ee692c3229613` (`teamId`),
  KEY `FK_95be5679a7cfc415e386ce79b19` (`matchId`),
  CONSTRAINT `FK_95be5679a7cfc415e386ce79b19` FOREIGN KEY (`matchId`) REFERENCES `match` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_f96da3ac7e4853ee692c3229613` FOREIGN KEY (`teamId`) REFERENCES `team` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: league
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `league` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `shortName` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_110716368f5130cdc669dacea4` (`name`),
  UNIQUE KEY `IDX_35786d3e1fad74108ad45e7177` (`shortName`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: league_admins_user
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `league_admins_user` (
  `leagueId` varchar(36) NOT NULL,
  `userId` varchar(36) NOT NULL,
  PRIMARY KEY (`leagueId`, `userId`),
  KEY `IDX_27fa3b85945ecb1c7760284281` (`leagueId`),
  KEY `IDX_c7f24fe0cf115869676ae03aeb` (`userId`),
  CONSTRAINT `FK_27fa3b85945ecb1c7760284281b` FOREIGN KEY (`leagueId`) REFERENCES `league` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_c7f24fe0cf115869676ae03aebf` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: league_observers_user
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `league_observers_user` (
  `leagueId` varchar(36) NOT NULL,
  `userId` varchar(36) NOT NULL,
  PRIMARY KEY (`leagueId`, `userId`),
  KEY `IDX_eacdfa91fe8d48e255770e29a8` (`leagueId`),
  KEY `IDX_17541ba33c132078f9cc31b6ae` (`userId`),
  CONSTRAINT `FK_17541ba33c132078f9cc31b6ae3` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_eacdfa91fe8d48e255770e29a81` FOREIGN KEY (`leagueId`) REFERENCES `league` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: league_referees_user
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `league_referees_user` (
  `leagueId` varchar(36) NOT NULL,
  `userId` varchar(36) NOT NULL,
  PRIMARY KEY (`leagueId`, `userId`),
  KEY `IDX_1150828b5e10090130493ce5e5` (`leagueId`),
  KEY `IDX_26aef4daf9a7abe57d825770f3` (`userId`),
  CONSTRAINT `FK_1150828b5e10090130493ce5e51` FOREIGN KEY (`leagueId`) REFERENCES `league` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_26aef4daf9a7abe57d825770f38` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: match
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `match` (
  `id` varchar(36) NOT NULL,
  `stadium` varchar(255) NOT NULL,
  `homeTeamId` varchar(255) NOT NULL,
  `awayTeamId` varchar(255) NOT NULL,
  `refereeId` varchar(255) NOT NULL,
  `observerId` varchar(255) NOT NULL,
  `leagueId` varchar(255) NOT NULL,
  `matchDate` datetime NOT NULL,
  `refereeGradeDate` datetime DEFAULT NULL,
  `userReadableKey` varchar(255) NOT NULL,
  `refereeSmsId` varchar(255) DEFAULT NULL,
  `observerSmsId` varchar(255) DEFAULT NULL,
  `refereeGrade` float DEFAULT NULL,
  `overallGradeDate` datetime DEFAULT NULL,
  `refereeNote` varchar(1000) DEFAULT NULL,
  `overallGrade` varchar(3000) DEFAULT NULL,
  `observerReportKey` varchar(255) DEFAULT NULL,
  `mentorReportKey` varchar(255) DEFAULT NULL,
  `tvReportKey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_191f38ef31c1d267e8c3fa8327` (`userReadableKey`),
  KEY `FK_5caac1768e2f5b7b9c69b62090c` (`homeTeamId`),
  KEY `FK_07f5b02809e195be415834ed78a` (`awayTeamId`),
  KEY `FK_d3af13a96b05bd93cf7c499dc20` (`refereeId`),
  KEY `FK_0bd801e53f4c6f5f7c113d96ad7` (`observerId`),
  KEY `FK_96c1ded1c8c70d8bf2f9d486b38` (`leagueId`),
  CONSTRAINT `FK_07f5b02809e195be415834ed78a` FOREIGN KEY (`awayTeamId`) REFERENCES `team` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_0bd801e53f4c6f5f7c113d96ad7` FOREIGN KEY (`observerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_5caac1768e2f5b7b9c69b62090c` FOREIGN KEY (`homeTeamId`) REFERENCES `team` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_96c1ded1c8c70d8bf2f9d486b38` FOREIGN KEY (`leagueId`) REFERENCES `league` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_d3af13a96b05bd93cf7c499dc20` FOREIGN KEY (`refereeId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: team
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `team` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `leagueId` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_cf461f5b40cf1a2b8876011e1e` (`name`),
  KEY `FK_36d02c93049412c8e95bd478de9` (`leagueId`),
  CONSTRAINT `FK_36d02c93049412c8e95bd478de9` FOREIGN KEY (`leagueId`) REFERENCES `league` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: user
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user` (
  `id` varchar(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_e12875dfb3b1d92d7d7c5377e2` (`email`),
  UNIQUE KEY `IDX_f2578043e491921209f5dadd08` (`phoneNumber`),
  UNIQUE KEY `IDX_f0e1b4ecdca13b177e2e3a0613` (`lastName`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: feature
# ------------------------------------------------------------

INSERT INTO
  `feature` (`id`, `type`, `description`, `refereeId`, `matchId`)
VALUES
  (
    '6ea4a9fe-008c-11ed-81bf-960000b5fbdb',
    'Positive',
    'Dobra polityka kartkowa',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );
INSERT INTO
  `feature` (`id`, `type`, `description`, `refereeId`, `matchId`)
VALUES
  (
    '73208d46-008c-11ed-81bf-960000b5fbdb',
    'Positive',
    'Odpowiednie ustawianie się',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );
INSERT INTO
  `feature` (`id`, `type`, `description`, `refereeId`, `matchId`)
VALUES
  (
    '77ff0e33-008c-11ed-81bf-960000b5fbdb',
    'Positive',
    'Wbieganie w pole karne w decyzjach krytycznych',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );
INSERT INTO
  `feature` (`id`, `type`, `description`, `refereeId`, `matchId`)
VALUES
  (
    '7dd41c24-008c-11ed-81bf-960000b5fbdb',
    'Negative',
    'Zły timming decyzji',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );
INSERT INTO
  `feature` (`id`, `type`, `description`, `refereeId`, `matchId`)
VALUES
  (
    '817fef10-008c-11ed-81bf-960000b5fbdb',
    'Negative',
    'Zbyt flegmatyczna reakcja po przerwaniu gry',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: foul
# ------------------------------------------------------------

INSERT INTO
  `foul` (
    `id`,
    `minute`,
    `card`,
    `playerNumber`,
    `description`,
    `valid`,
    `teamId`,
    `matchId`
  )
VALUES
  (
    '5fc00160-0074-11ed-81bf-960000b5fbdb',
    10,
    'Yellow',
    23,
    'Podważanie dobrej decyzji sędziego - słowa do niego \"co ty kurwa gwiżdżesz\"',
    1,
    'be208742-03a6-4eb4-9cbf-467289f7c29a',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );
INSERT INTO
  `foul` (
    `id`,
    `minute`,
    `card`,
    `playerNumber`,
    `description`,
    `valid`,
    `teamId`,
    `matchId`
  )
VALUES
  (
    '667d50de-0074-11ed-81bf-960000b5fbdb',
    20,
    'Red',
    23,
    'Podważanie dobrej decyzji sędziego - słowa do niego \"co ty kurwa gwiżdżesz\"',
    1,
    'be208742-03a6-4eb4-9cbf-467289f7c29a',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );
INSERT INTO
  `foul` (
    `id`,
    `minute`,
    `card`,
    `playerNumber`,
    `description`,
    `valid`,
    `teamId`,
    `matchId`
  )
VALUES
  (
    '6cd31a6a-0074-11ed-81bf-960000b5fbdb',
    25,
    'Red',
    23,
    'Podważanie dobrej decyzji sędziego - słowa do niego \"co ty kurwa gwiżdżesz\"',
    1,
    'be208742-03a6-4eb4-9cbf-467289f7c29a',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );
INSERT INTO
  `foul` (
    `id`,
    `minute`,
    `card`,
    `playerNumber`,
    `description`,
    `valid`,
    `teamId`,
    `matchId`
  )
VALUES
  (
    '72991214-0074-11ed-81bf-960000b5fbdb',
    45,
    'Yellow',
    23,
    'Podważanie dobrej decyzji sędziego - słowa do niego \"co ty kurwa gwiżdżesz\"',
    1,
    'be208742-03a6-4eb4-9cbf-467289f7c29a',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );
INSERT INTO
  `foul` (
    `id`,
    `minute`,
    `card`,
    `playerNumber`,
    `description`,
    `valid`,
    `teamId`,
    `matchId`
  )
VALUES
  (
    '762ec1a2-0074-11ed-81bf-960000b5fbdb',
    75,
    'Yellow',
    23,
    'Podważanie dobrej decyzji sędziego - słowa do niego \"co ty kurwa gwiżdżesz\"',
    1,
    'be208742-03a6-4eb4-9cbf-467289f7c29a',
    '9ed430ee-d21d-404b-9160-3063c1408ec1'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: league
# ------------------------------------------------------------

INSERT INTO
  `league` (`id`, `name`, `shortName`, `country`)
VALUES
  (
    '3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d',
    'asd123132',
    '123',
    'asdsd'
  );
INSERT INTO
  `league` (`id`, `name`, `shortName`, `country`)
VALUES
  (
    '71b2ae4e-7b61-4793-8c68-dc390d8450c1',
    'IV Liga Lubelska',
    '4LBN',
    'Polska'
  );
INSERT INTO
  `league` (`id`, `name`, `shortName`, `country`)
VALUES
  (
    'a58a9062-9c31-42a6-9ce4-f80fc2ff8e82',
    'Fußball-Bundesliga',
    'DFL',
    'Germany'
  );
INSERT INTO
  `league` (`id`, `name`, `shortName`, `country`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    'PKO BP Ekstraklasa',
    'PLE',
    'Poland'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: league_admins_user
# ------------------------------------------------------------

INSERT INTO
  `league_admins_user` (`leagueId`, `userId`)
VALUES
  (
    '3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d',
    'b35eca20-cdf7-11ec-81bf-960000b5fbdb'
  );
INSERT INTO
  `league_admins_user` (`leagueId`, `userId`)
VALUES
  (
    '71b2ae4e-7b61-4793-8c68-dc390d8450c1',
    '9a926f81-cd4c-11ec-81bf-960000b5fbdb'
  );
INSERT INTO
  `league_admins_user` (`leagueId`, `userId`)
VALUES
  (
    'a58a9062-9c31-42a6-9ce4-f80fc2ff8e82',
    'e191b1ea-cae8-11ec-81bf-960000b5fbdb'
  );
INSERT INTO
  `league_admins_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '9a926f81-cd4c-11ec-81bf-960000b5fbdb'
  );
INSERT INTO
  `league_admins_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    'e191b1ea-cae8-11ec-81bf-960000b5fbdb'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: league_observers_user
# ------------------------------------------------------------

INSERT INTO
  `league_observers_user` (`leagueId`, `userId`)
VALUES
  (
    '3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0'
  );
INSERT INTO
  `league_observers_user` (`leagueId`, `userId`)
VALUES
  (
    'a58a9062-9c31-42a6-9ce4-f80fc2ff8e82',
    'bc55d2e3-2b84-4982-b04a-1c169b82e4c4'
  );
INSERT INTO
  `league_observers_user` (`leagueId`, `userId`)
VALUES
  (
    'a58a9062-9c31-42a6-9ce4-f80fc2ff8e82',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e'
  );
INSERT INTO
  `league_observers_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '143e808d-e7e2-4926-b65c-db46944dcfcd'
  );
INSERT INTO
  `league_observers_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0'
  );
INSERT INTO
  `league_observers_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: league_referees_user
# ------------------------------------------------------------

INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    '3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d',
    '393a0797-1f6d-42f0-b1f9-ef120d6756c7'
  );
INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    'a58a9062-9c31-42a6-9ce4-f80fc2ff8e82',
    '6e5860db-7e9c-4e79-a2e1-1c793f4cd821'
  );
INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155'
  );
INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '393a0797-1f6d-42f0-b1f9-ef120d6756c7'
  );
INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '4a7163b5-221b-4da2-86c4-a71b97246c17'
  );
INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    'a6eb2b1d-5e6d-4130-859d-71d669f27c27'
  );
INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    'b2ae81b8-7a32-44b6-8866-b841fac262b6'
  );
INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    'd02750e0-1401-4435-b82d-2cb81101e8ba'
  );
INSERT INTO
  `league_referees_user` (`leagueId`, `userId`)
VALUES
  (
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    'd85953b3-e7b6-40f8-8a92-308a824f0b58'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: match
# ------------------------------------------------------------

INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '0aa66087-d11e-4bb5-8a5a-6932dc457427',
    'some stadium',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    '4a7163b5-221b-4da2-86c4-a71b97246c17',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-05-04 05:33:00',
    '2022-05-04 05:33:00',
    '0405220102',
    NULL,
    NULL,
    7.6,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '0b0a10ca-ed8f-4000-8bd8-28ae3c0f3fdd',
    'some stadium',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-07 07:00:00',
    '2022-06-07 21:56:10',
    '0706220102',
    NULL,
    '13394754',
    9.99,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '14137ef6-3948-4e4f-80a5-cc38705c5671',
    'some stadium',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-10 18:00:00',
    NULL,
    '1006220102',
    NULL,
    '13511046',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '33ab4f6c-3341-4c39-a835-d9dc0b6ae9d0',
    'some stadium',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    'b2ae81b8-7a32-44b6-8866-b841fac262b6',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-05-06 00:32:00',
    '2022-05-06 00:32:00',
    '0605220101',
    NULL,
    NULL,
    8.9,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '3a355f44-8bde-4eeb-8b5f-c8516a6222be',
    'Ulica jakaś, miasto jakieś',
    '9714dbdf-82e3-4153-a67b-993731583ff8',
    '6ae8876b-13ff-48a5-a2d3-9c718a29fc9a',
    '393a0797-1f6d-42f0-b1f9-ef120d6756c7',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0',
    '3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d',
    '2022-07-27 18:30:00',
    NULL,
    '2707220101',
    NULL,
    '14311915',
    NULL,
    NULL,
    NULL,
    NULL,
    'league=3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d/match=3a355f44-8bde-4eeb-8b5f-c8516a6222be/report=Observer/Observer 2022-07-17T10:40:04:822.pdf',
    'league=3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d/match=3a355f44-8bde-4eeb-8b5f-c8516a6222be/report=Mentor/Mentor 2022-07-17T10:49:43:333.pdf',
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '3c543888-fb8c-4644-a813-74852c54b776',
    'some stadium',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-14 07:00:00',
    NULL,
    '1406220103',
    NULL,
    '13644803',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '45267de5-fb70-491e-8602-c69f39de2e70',
    'some stadium',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '4a7163b5-221b-4da2-86c4-a71b97246c17',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-05-04 16:48:00',
    NULL,
    '0405220103',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '48790087-ff19-44c1-8e60-91ee6378184d',
    'some stadium',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-14 19:05:00',
    '2022-06-15 10:36:27',
    '1406220102',
    NULL,
    '13634693',
    6.5,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '6d9c1b72-03ba-43ee-9f97-9399afd90dcb',
    'some stadium',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-07 08:53:00',
    '2022-06-17 08:09:22',
    '0706220103',
    NULL,
    '13394753',
    3.4,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '783d63e9-5c01-4a74-842b-ec3a6bba50a8',
    'some stadium',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    'd02750e0-1401-4435-b82d-2cb81101e8ba',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-05-29 22:45:00',
    '2022-06-07 10:49:37',
    '0105220102',
    NULL,
    NULL,
    5.9,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '798b1d35-43fa-41c3-adf5-7c336e6c2699',
    'some stadium',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    '4a7163b5-221b-4da2-86c4-a71b97246c17',
    '143e808d-e7e2-4926-b65c-db46944dcfcd',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-05 14:00:00',
    '2022-06-08 11:42:41',
    '0506220103',
    NULL,
    '13423946',
    8.4,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '8ce0d73c-1c8c-4dbd-ae28-8860a680fa39',
    'some stadium',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    'd02750e0-1401-4435-b82d-2cb81101e8ba',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-05-30 14:30:00',
    NULL,
    '0205220103',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    '9ed430ee-d21d-404b-9160-3063c1408ec1',
    'some stadium',
    'be208742-03a6-4eb4-9cbf-467289f7c29a',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-07-28 10:01:00',
    NULL,
    '2807220101',
    NULL,
    '14312123',
    NULL,
    '2022-07-10 22:21:33',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    'b1e3d7b2-976e-42fa-8994-c7e0c7bb2289',
    'some stadium',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '4a7163b5-221b-4da2-86c4-a71b97246c17',
    '143e808d-e7e2-4926-b65c-db46944dcfcd',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-11 10:45:00',
    NULL,
    '1106220105',
    NULL,
    '14313485',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    'b844c252-0bc5-4860-9cde-8b95be78a9ef',
    'some stadium',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    '143e808d-e7e2-4926-b65c-db46944dcfcd',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-04 14:00:00',
    NULL,
    '0406220103',
    NULL,
    '13423998',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    'c02160f3-d499-498d-a161-07c7d309b54c',
    'some stadium',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    '143e808d-e7e2-4926-b65c-db46944dcfcd',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-08 09:51:00',
    NULL,
    '0806220102',
    NULL,
    '13423923',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    'c0a39167-82ae-4a93-9e9c-5403ad369c67',
    'Ulica jakaś, miasto jakieś',
    '6ae8876b-13ff-48a5-a2d3-9c718a29fc9a',
    '9714dbdf-82e3-4153-a67b-993731583ff8',
    '393a0797-1f6d-42f0-b1f9-ef120d6756c7',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0',
    '3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d',
    '2022-07-26 18:30:00',
    NULL,
    '2607220102',
    NULL,
    '14311916',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    'c16eb92d-6371-4f33-b173-f937a16db8b9',
    'some stadium',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    '4a7163b5-221b-4da2-86c4-a71b97246c17',
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-11 05:33:00',
    NULL,
    '1106220102',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    'c6ad811c-3420-431d-ba48-d1033e9e6f5b',
    'some stadium',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-15 08:45:00',
    '2022-06-15 14:58:15',
    '1506220103',
    NULL,
    '13656196',
    7.3,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    'e94c0c6b-db35-478d-bf19-8dfb5ccd8d43',
    'some stadium',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-06-07 09:00:00',
    NULL,
    '0706220101',
    NULL,
    '13394751',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `match` (
    `id`,
    `stadium`,
    `homeTeamId`,
    `awayTeamId`,
    `refereeId`,
    `observerId`,
    `leagueId`,
    `matchDate`,
    `refereeGradeDate`,
    `userReadableKey`,
    `refereeSmsId`,
    `observerSmsId`,
    `refereeGrade`,
    `overallGradeDate`,
    `refereeNote`,
    `overallGrade`,
    `observerReportKey`,
    `mentorReportKey`,
    `tvReportKey`
  )
VALUES
  (
    'fc577b94-e1e2-42cf-96e4-b540ca5d1b24',
    'some stadium',
    '234a6228-e5df-49b8-80be-cf6424f6f39b',
    '296cd48d-89fa-464f-9937-b0680b134e00',
    '393a0797-1f6d-42f0-b1f9-ef120d6756c7',
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a',
    '2022-07-30 08:30:00',
    '2022-06-15 16:45:34',
    '3007220102',
    NULL,
    '14312823',
    2.5,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: team
# ------------------------------------------------------------

INSERT INTO
  `team` (`id`, `name`, `leagueId`)
VALUES
  (
    '234a6228-e5df-49b8-80be-cf6424f6f39b',
    'FC Porto',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a'
  );
INSERT INTO
  `team` (`id`, `name`, `leagueId`)
VALUES
  (
    '296cd48d-89fa-464f-9937-b0680b134e00',
    'Legia Warszawa',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a'
  );
INSERT INTO
  `team` (`id`, `name`, `leagueId`)
VALUES
  (
    '6ae8876b-13ff-48a5-a2d3-9c718a29fc9a',
    'Nowa Druzyna',
    '3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d'
  );
INSERT INTO
  `team` (`id`, `name`, `leagueId`)
VALUES
  (
    '8807edaa-6df0-42de-a776-3477f55d75b5',
    'Raków Częstochowa',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a'
  );
INSERT INTO
  `team` (`id`, `name`, `leagueId`)
VALUES
  (
    '9714dbdf-82e3-4153-a67b-993731583ff8',
    'Druga druzyna',
    '3fef131c-4c09-4dc8-b3b2-1c3bf8d5d72d'
  );
INSERT INTO
  `team` (`id`, `name`, `leagueId`)
VALUES
  (
    'be208742-03a6-4eb4-9cbf-467289f7c29a',
    'FC Barcelona',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a'
  );
INSERT INTO
  `team` (`id`, `name`, `leagueId`)
VALUES
  (
    'de2fa7b1-5a27-4355-a039-5825d22639be',
    'Lech Poznań',
    'aea05e5c-09be-4c8f-b59e-bf8d09e33f7a'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: user
# ------------------------------------------------------------

INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '0b2368b7-d0f0-4061-9157-651f8bda7f44',
    'depj@gmail123.com',
    'Observer',
    '+80 2112 22 2908',
    'Johnnyy',
    'Depp'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '143e808d-e7e2-4926-b65c-db46944dcfcd',
    'graderefobserver@gmail.com',
    'Observer',
    '724266825',
    'John',
    'Observer'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '1ebbaeff-8dba-4192-8f7c-eff83d010155',
    'graderefreferee@gmail.com',
    'Referee',
    '+21222333444',
    'Bartosz',
    'Switalski3'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '2dab2c05-60c1-4dca-a69b-6f0a03f40347',
    'jamiedoe@gmaill.com',
    'Observer',
    '123124',
    'Jamie',
    'Doe'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '393a0797-1f6d-42f0-b1f9-ef120d6756c7',
    'julius.caesar233@gmail12.com',
    'Referee',
    '124141235',
    'Juliusss',
    'Caesar'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '4a7163b5-221b-4da2-86c4-a71b97246c17',
    'johndoe@gmail21.com',
    'Referee',
    '2141241111',
    'John',
    'Doe1'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '62758201-7a43-4315-b346-81e282acd4a3',
    'newref@gmaiiiil.com',
    'Referee',
    '21312',
    'New',
    'Ref'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '6e5860db-7e9c-4e79-a2e1-1c793f4cd821',
    'jane.doe@gmail1.com',
    'Referee',
    '21241244124',
    'Jane',
    'Doe2'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '7137a8e6-0c0a-480f-a774-b84840fa3ff0',
    'bgates@gmail1.com',
    'Observer',
    '796175646',
    'Bill',
    'Gates'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '82e68988-4568-4c61-b0b4-a820deca96b4',
    'boofar@gmaill.com',
    'Admin',
    '214124',
    'Boo',
    'Far'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '87ea4dfd-cd3a-11ec-81bf-960000b5fbdb',
    'dawidbrzozowski98@gmail.com',
    'Admin',
    '111',
    'Dawid',
    'Brzozowski'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    '9a926f81-cd4c-11ec-81bf-960000b5fbdb',
    'karolkowalskistaszic@gmail.com',
    'Admin',
    '111111112',
    'Karol',
    'Kowalski'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'a6eb2b1d-5e6d-4130-859d-71d669f27c27',
    'ratkins@gmail21.com',
    'Referee',
    '+48 235 431 333',
    'Rowan',
    'Atkinson'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'b2ae81b8-7a32-44b6-8866-b841fac262b6',
    'jackdoe@gmaail.com',
    'Referee',
    '21421251',
    'Jackson',
    'Doe3'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'b35eca20-cdf7-11ec-81bf-960000b5fbdb',
    'kqmdjc8@gmail.com',
    'Admin',
    '11111111787878',
    'Aleksander',
    'Błaszkiewicz'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'bc55d2e3-2b84-4982-b04a-1c169b82e4c4',
    'batman@gmail2.com',
    'Observer',
    '+48 123 456 789',
    'Bruce',
    'Wayne'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'be6e0fdf-56f1-4001-b4fd-0457ed21d989',
    'newRef2333@gmail.comm',
    'Referee',
    '23142',
    'New',
    'Referee'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'c3c1ab99-cace-11ec-81bf-960000b5fbdb',
    'bswitalski.main@gmail.com',
    'Owner',
    '+48123456789',
    'Bartosz',
    'Switalski'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'cb124cd4-0bfa-4053-abc6-111138eb3071',
    'some.obs@mail21112.com',
    'Observer',
    '+482319482',
    'Some',
    'Observer1'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'd02750e0-1401-4435-b82d-2cb81101e8ba',
    'obamab@gmail1.com',
    'Referee',
    '+22 22214 421 21',
    'Barack',
    '0bama'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'd44fc7d0-969c-4f2e-b385-b9f36e2cf37e',
    'bartus.switalski@gmail.com',
    'Observer',
    '669797907',
    'Bartosz',
    'Switalski1'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'd85953b3-e7b6-40f8-8a92-308a824f0b58',
    'hwebb@gmail1.com',
    'Referee',
    '1231251235125',
    'Howard',
    'Webb'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'dbc8a9b0-cd66-11ec-81bf-960000b5fbdb',
    'kurowski.pawel.98@gmail.com',
    'Admin',
    '1111111133',
    'Paweł',
    'Kurowski'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'e191b1ea-cae8-11ec-81bf-960000b5fbdb',
    'bswitalski.misc@gmail.com',
    'Admin',
    '+48111222333',
    'Bartosz',
    'Switalski2'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'e441fe38-f726-4b9a-8ad2-ae2da7b39f79',
    'bwayneee@gmaill21.com',
    'Admin',
    '21904812',
    'Big',
    'Waynee'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'e6213f1e-cd66-11ec-81bf-960000b5fbdb',
    'kudzianka@gmail.com',
    'Admin',
    '1111111122',
    'Anna',
    'Kudzia'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'f180a5cd-cd66-11ec-81bf-960000b5fbdb',
    'robert.lniski@gmail.com',
    'Admin',
    '11111111',
    'Robert',
    'Lniski'
  );
INSERT INTO
  `user` (
    `id`,
    `email`,
    `role`,
    `phoneNumber`,
    `firstName`,
    `lastName`
  )
VALUES
  (
    'f6d449f0-3d72-4f92-92a4-c290ce75797c',
    'amberturd@gmaiiil.com',
    'Observer',
    '24142189',
    'Amber',
    'Turd'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
