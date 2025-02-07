

CREATE TABLE IF NOT EXISTS 'ML_CIV_VII_Exploration_Civilizations'  (
Civilization text not null,
primary key (Civilization)
);


INSERT OR IGNORE INTO ML_CIV_VII_Exploration_Civilizations
(Civilization	)
VALUES
('CIVILIZATION_ABBASID'		),
('CIVILIZATION_CHOLA'		),
('CIVILIZATION_HAWAII'		),
('CIVILIZATION_INCA'		),
('CIVILIZATION_MAJAPAHIT'	),
('CIVILIZATION_MING'		),
('CIVILIZATION_MONGOLIA'	),
('CIVILIZATION_NORMAN'		),
('CIVILIZATION_SONGHAI'		),
('CIVILIZATION_SPAIN'		);


CREATE TABLE IF NOT EXISTS 'ML_CIV_VII_Exploration_Civilizations_Unlocks'  (
UnlockType text not null,
primary key (UnlockType)
);


INSERT OR IGNORE INTO ML_CIV_VII_Exploration_Civilizations_Unlocks
(UnlockType	)
SELECT
'UNLOCK_'||Civilization
FROM ML_CIV_VII_Exploration_Civilizations;

INSERT OR IGNORE INTO Types
(Type,					Kind)
SELECT
UnlockType||'_MODERN',	'KIND_UNLOCK'
FROM ML_CIV_VII_Exploration_Civilizations_Unlocks;

INSERT OR IGNORE INTO Unlocks
(UnlockType)
SELECT
UnlockType||'_MODERN'
FROM ML_CIV_VII_Exploration_Civilizations_Unlocks;


INSERT OR IGNORE INTO UnlockRequirements
(RequirementSetId,		UnlockType,					Description,		NarrativeText,		ToolTip)
SELECT
RequirementSetId,		UnlockType||'_MODERN',		Description,		NarrativeText,		ToolTip
FROM UnlockRequirements WHERE UnlockType IN (SELECT UnlockType IN ML_CIV_VII_Exploration_Civilizations_Unlocks);


INSERT OR IGNORE INTO UnlockConfigurationValues
(UnlockType,			ConfigurationValue)
SELECT
UnlockType||'_MODERN',	ConfigurationValue||'_MODERN'
FROM UnlockConfigurationValues WHERE UnlockType IN (SELECT UnlockType IN ML_CIV_VII_Exploration_Civilizations_Unlocks);


