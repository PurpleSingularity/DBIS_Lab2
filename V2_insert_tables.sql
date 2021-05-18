-- Subject Filling
INSERT INTO Subject (SubjectID, Subject)
VALUES 
    ('Ukr', 'Українська мова і література'),
    ('Hist', 'Історія України'),
    ('Math', 'Математика'),
    ('Phys', 'Фізика'),
    ('Chem', 'Хімія'),
    ('Bio', 'Біологія'),
    ('Geo', 'Географія'),
    ('Eng', 'Англійська мова'),
    ('Deu', 'Німецька мова'),
    ('Spa', 'Іспанська мова'),
    ('Fra', 'Французька мова'),
    ('Rus', 'Російська мова');
---------------------------------------------------------------------------------------------------------------------------------------------

-- Student Filling
INSERT INTO Student(OutID, Birth, SextypeName, RegName, AreaName, TerName, RegTypeName, TerTypeName, ClassProfileName, ClassLangName)
SELECT OutID, Birth, SextypeName, RegName, AreaName, TerName, RegTypeName, TerTypeName, ClassProfileName, ClassLangName
FROM results;
---------------------------------------------------------------------------------------------------------------------------------------------

-- Place Filling
INSERT INTO Place(PName, TypeName, RegName, AreaName, TerName, Parent)
SELECT DISTINCT TRIM(EOName) as PName,
                TRIM(EOTypeName) as TypeName,
                TRIM(EORegName) as RegName,
                TRIM(EOAreaName) as AreaName,
                TRIM(EOTerName) as TerName,
                TRIM(EOParent) as Parent
FROM results FULL OUTER JOIN
(
    SELECT DISTINCT *
    FROM 
    (
        SELECT TRIM(ukrPTName) as PName,
               TRIM(ukrPTRegName) as RegName,
               TRIM(ukrPTAreaName) as AreaName,
               TRIM(ukrPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(histPTName) as PName,
               TRIM(histPTRegName) as RegName,
               TRIM(histPTAreaName) as AreaName,
               TRIM(histPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(mathPTName) as PName,
               TRIM(mathPTRegName) as RegName,
               TRIM(mathPTAreaName) as AreaName,
               TRIM(mathPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(physPTName) as PName,
               TRIM(physPTRegName) as RegName,
               TRIM(physPTAreaName) as AreaName,
               TRIM(physPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(chemPTName) as PName,
               TRIM(chemPTRegName) as RegName,
               TRIM(chemPTAreaName) as AreaName,
               TRIM(chemPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(bioPTName) as PName,
               TRIM(bioPTRegName) as RegName,
               TRIM(bioPTAreaName) as AreaName,
               TRIM(bioPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(geoPTName) as PName,
               TRIM(geoPTRegName) as RegName,
               TRIM(geoPTAreaName) as AreaName,
               TRIM(geoPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(engPTName) as PName,
               TRIM(engPTRegName) as RegName,
               TRIM(engPTAreaName) as AreaName,
               TRIM(engPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(fraPTName) as PName,
               TRIM(fraPTRegName) as RegName,
               TRIM(fraPTAreaName) as AreaName,
               TRIM(fraPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(deuPTName) as PName,
               TRIM(deuPTRegName) as RegName,
               TRIM(deuPTAreaName) as AreaName,
               TRIM(deuPTTerName) as TerName
        FROM results
        UNION
        SELECT TRIM(spaPTName) as PName,
               TRIM(spaPTRegName) as RegName,
               TRIM(spaPTAreaName) as AreaName,
               TRIM(spaPTTerName) as TerName
        FROM results
    ) AS big_union
) AS TMP
ON  TRIM(results.EOName)     = TMP.PName
AND TRIM(results.EORegName)  = TMP.RegName
AND TRIM(results.EOAreaName) = TMP.AreaName
AND TRIM(results.EOTerName)  = TMP.TerName;
---------------------------------------------------------------------------------------------------------------------------------------------

-- StudyPlace Filling
INSERT INTO StudyPlace (OutID, PlaceID)
SELECT OutID, PlaceID
FROM results INNER JOIN Place
ON  TRIM(results.EOName)     = Place.PName
AND TRIM(results.EORegName)  = Place.RegName
AND TRIM(results.EOAreaName) = Place.AreaName
AND TRIM(results.EOTerName)  = Place.TerName;
---------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO ZNOResult (OutId, SubjectID, PlaceID, Lang, TestStatus, DPALevel, Ball100, Ball12, Ball, AdaptScale, Year)
SELECT OutId, SubjectID, PlaceID, Lang, TestStatus, DPALevel, Ball100, Ball12, Ball, AdaptScale, Year
FROM
((
    SELECT OutID,
           ukrTest       as Test,
           TRIM(ukrPTName) as PName,
           TRIM(ukrPTRegName) as RegName,
           TRIM(ukrPTAreaName) as AreaName,
           TRIM(ukrPTTerName) as TerName,
           NULL          as Lang,
           ukrTestStatus as TestStatus,
           NULL          as DPALevel,
           ukrBall100    as Ball100,
           ukrBall12     as Ball12,
           ukrBall       as Ball,
           ukrAdaptScale as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           histTest       as Test,
           TRIM(histPTName) as PName,
           TRIM(histPTRegName) as RegName,
           TRIM(histPTAreaName) as AreaName,
           TRIM(histPTTerName) as TerName,
           histLang       as Lang,
           histTestStatus as TestStatus,
           NULL           as DPALevel,
           histBall100    as Ball100,
           histBall12     as Ball12,
           histBall       as Ball,
           NULL           as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           mathTest       as Test,
           TRIM(mathPTName) as PName,
           TRIM(mathPTRegName) as RegName,
           TRIM(mathPTAreaName) as AreaName,
           TRIM(mathPTTerName) as TerName,
           mathLang       as Lang,
           mathTestStatus as TestStatus,
           NULL           as DPALevel,
           mathBall100    as Ball100,
           mathBall12     as Ball12,
           mathBall       as Ball,
           NULL           as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           physTest       as Test,
           TRIM(physPTName) as PName,
           TRIM(physPTRegName) as RegName,
           TRIM(physPTAreaName) as AreaName,
           TRIM(physPTTerName) as TerName,
           physLang       as Lang,
           physTestStatus as TestStatus,
           NULL           as DPALevel,
           physBall100    as Ball100,
           physBall12     as Ball12,
           physBall       as Ball,
           NULL           as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           chemTest       as Test,
           TRIM(chemPTName) as PName,
           TRIM(chemPTRegName) as RegName,
           TRIM(chemPTAreaName) as AreaName,
           TRIM(chemPTTerName) as TerName,
           chemLang       as Lang,
           chemTestStatus as TestStatus,
           NULL           as DPALevel,
           chemBall100    as Ball100,
           chemBall12     as Ball12,
           chemBall       as Ball,
           NULL           as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           bioTest       as Test,
           TRIM(bioPTName) as PName,
           TRIM(bioPTRegName) as RegName,
           TRIM(bioPTAreaName) as AreaName,
           TRIM(bioPTTerName) as TerName,
           bioLang       as Lang,
           bioTestStatus as TestStatus,
           NULL          as DPALevel,
           bioBall100    as Ball100,
           bioBall12     as Ball12,
           bioBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           geoTest       as Test,
           TRIM(geoPTName) as PName,
           TRIM(geoPTRegName) as RegName,
           TRIM(geoPTAreaName) as AreaName,
           TRIM(geoPTTerName) as TerName,
           geoLang       as Lang,
           geoTestStatus as TestStatus,
           NULL          as DPALevel,
           geoBall100    as Ball100,
           geoBall12     as Ball12,
           geoBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           engTest       as Test,
           TRIM(engPTName) as PName,
           TRIM(engPTRegName) as RegName,
           TRIM(engPTAreaName) as AreaName,
           TRIM(engPTTerName) as TerName,
           NULL          as Lang,
           engTestStatus as TestStatus,
           engDPALevel   as DPALevel,
           engBall100    as Ball100,
           engBall12     as Ball12,
           engBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           fraTest       as Test,
           TRIM(fraPTName) as PName,
           TRIM(fraPTRegName) as RegName,
           TRIM(fraPTAreaName) as AreaName,
           TRIM(fraPTTerName) as TerName,
           NULL          as Lang,
           fraTestStatus as TestStatus,
           fraDPALevel   as DPALevel,
           fraBall100    as Ball100,
           fraBall12     as Ball12,
           fraBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           deuTest       as Test,
           TRIM(deuPTName) as PName,
           TRIM(deuPTRegName) as RegName,
           TRIM(deuPTAreaName) as AreaName,
           TRIM(deuPTTerName) as TerName,
           NULL          as Lang,
           deuTestStatus as TestStatus,
           deuDPALevel   as DPALevel,
           deuBall100    as Ball100,
           deuBall12     as Ball12,
           deuBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM results
    UNION
    SELECT OutID,
           spaTest       as Test,
           TRIM(spaPTName) as PName,
           TRIM(spaPTRegName) as RegName,
           TRIM(spaPTAreaName) as AreaName,
           TRIM(spaPTTerName) as TerName,
           NULL          as Lang,
           spaTestStatus as TestStatus,
           spaDPALevel   as DPALevel,
           spaBall100    as Ball100,
           spaBall12     as Ball12,
           spaBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM results
) as big_union INNER JOIN Subject
ON TRIM(big_union.Test) = Subject.Subject
) as TMP INNER JOIN Place
ON TMP.PName     = Place.PName
AND TMP.RegName  = Place.RegName
AND TMP.AreaName = Place.AreaName
AND TMP.TerName  = Place.TerName;