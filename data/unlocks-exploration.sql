

CREATE TABLE IF NOT EXISTS 'ML_CIV_VII_Exploration_Civilizations'  (
Civilization text not null,
primary key (Civilization)
);

DELETE FROM ML_CIV_VII_Exploration_Civilizations;

INSERT OR IGNORE INTO ML_CIV_VII_Exploration_Civilizations
(Civilization	)
SELECT
CivilizationType
FROM Civilizations WHERE StartingCivilizationLevelType='CIVILIZATION_LEVEL_FULL_CIV';


CREATE TABLE IF NOT EXISTS 'ML_CIV_VII_Exploration_Civilizations_Unlocks'  (
UnlockType text not null,
primary key (UnlockType)
);

DELETE FROM ML_CIV_VII_Exploration_Civilizations_Unlocks;

INSERT OR IGNORE INTO ML_CIV_VII_Exploration_Civilizations_Unlocks
(UnlockType    )
SELECT
'UNLOCK_'||Civilization
FROM ML_CIV_VII_Exploration_Civilizations;



INSERT INTO Requirements 
    (RequirementId,                                        RequirementType                        )
SELECT
    'REQUIRES_CIV_IS_'||Civilization||'_FOR_MD',        'REQUIREMENT_PLAYER_CIVILIZATION_TYPE_MATCHES'
FROM ML_CIV_VII_Exploration_Civilizations;

INSERT INTO RequirementArguments
    (RequirementId,                                        Name,                    Value    )
SELECT
    'REQUIRES_CIV_IS_'||Civilization||'_FOR_MD',        'CivilizationType',        Civilization
FROM ML_CIV_VII_Exploration_Civilizations;

INSERT INTO RequirementSets
    (RequirementSetId,                            RequirementSetType            )
SELECT
    'REQSET_CIV_IS_UNLOCK_'||Civilization,        'REQUIREMENTSET_TEST_ALL'
FROM ML_CIV_VII_Exploration_Civilizations;

INSERT INTO RequirementSetRequirements
    (RequirementSetId,                            RequirementId                    )
SELECT
    'REQSET_CIV_IS_UNLOCK_'||Civilization,        'REQUIRES_CIV_IS_'||Civilization||'_FOR_MD'
FROM ML_CIV_VII_Exploration_Civilizations;


INSERT OR IGNORE INTO Types
(Type,                    Kind)
SELECT
UnlockType||'_MODERN',    'KIND_UNLOCK'
FROM ML_CIV_VII_Exploration_Civilizations_Unlocks;

INSERT OR IGNORE INTO Unlocks
(UnlockType)
SELECT
UnlockType||'_MODERN'
FROM ML_CIV_VII_Exploration_Civilizations_Unlocks;


INSERT OR IGNORE INTO UnlockRewards
(Name,    UnlockType,                CivUnlock,    Description,    Icon)
SELECT
Name,    UnlockType||'_MODERN',    CivUnlock,    Description,    Icon
FROM UnlockRewards WHERE UnlockType IN (SELECT UnlockType FROM ML_CIV_VII_Exploration_Civilizations_Unlocks);


-- 新增一种解锁条件
INSERT OR IGNORE INTO UnlockRequirements
(RequirementSetId,                    UnlockType,                    Description,        NarrativeText,        ToolTip)
SELECT
'REQSET_CIV_IS_'||UnlockType,        UnlockType||'_MODERN',        Description,        NarrativeText,        ToolTip
FROM UnlockRequirements WHERE UnlockType IN (SELECT UnlockType FROM ML_CIV_VII_Exploration_Civilizations_Unlocks);



INSERT OR IGNORE INTO UnlockConfigurationValues
(UnlockType,			ConfigurationValue)
SELECT
UnlockType||'_MODERN',	ConfigurationValue||'_MODERN'
FROM UnlockConfigurationValues WHERE UnlockType IN (SELECT UnlockType FROM ML_CIV_VII_Exploration_Civilizations_Unlocks);



