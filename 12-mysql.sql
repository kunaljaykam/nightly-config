-- https://raw.githubusercontent.com/sakaiproject/sakai/master/samigo/docs/auto_submit/auto_submit_mysql.sql

INSERT INTO SAM_ASSESSMETADATA_T (ASSESSMENTMETADATAID, ASSESSMENTID, LABEL, ENTRY) VALUES (NULL, 1, 'automaticSubmission_isInstructorEditable', 'true');

-- Run these SQL commands to update the templates
CREATE TEMPORARY TABLE UPDATE_SAM_AUTO_IDS AS (SELECT ID FROM SAM_ASSESSMENTBASE_T WHERE TYPEID='142' AND ISTEMPLATE=1);
-- You may need to clean this up if you've run it multiple times
-- DELETE FROM SAM_ASSESSMETADATA_T WHERE ASSESSMENTID IN (SELECT ID FROM UPDATE_SAM_AUTO_IDS) AND LABEL='automaticSubmission_isInstructorEditable';
INSERT INTO SAM_ASSESSMETADATA_T (ASSESSMENTMETADATAID, ASSESSMENTID, LABEL, ENTRY) SELECT NULL, ID, 'automaticSubmission_isInstructorEditable', 'true' FROM UPDATE_SAM_AUTO_IDS;
DROP TABLE UPDATE_SAM_AUTO_IDS;


-- Run these SQL commands to back fill to your existing assessments
CREATE TEMPORARY TABLE UPDATE_SAM_AUTO_IDS AS (SELECT ID FROM SAM_ASSESSMENTBASE_T WHERE ID NOT IN (SELECT ASSESSMENTID FROM SAM_ASSESSMETADATA_T WHERE label = 'automaticSubmission_isInstructorEditable'));
INSERT INTO SAM_ASSESSMETADATA_T (ASSESSMENTMETADATAID, ASSESSMENTID, LABEL, ENTRY) SELECT NULL, ID, 'automaticSubmission_isInstructorEditable', 'true' FROM UPDATE_SAM_AUTO_IDS;
DROP TABLE UPDATE_SAM_AUTO_IDS;
