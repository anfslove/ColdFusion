<cfscript>
	setting enablecfoutputonly="true" requesttimeout="150" showdebugoutput="false"; /* in seconds. */

	param name="form.role" type="string" default="user";

	location url="#pdfFile#?#RandRange(1,100)#" addtoken="false";

	if(!directoryExists(filesDir)){
		directory action="create" directory="#filesDir#";
	}

	if(directoryExists(empFilesDir)){
		directory action="delete" directory="#empFilesDir#" recurse="true";
	}

	transaction {
		try {
			queryObj = new query();
			queryObj.setDatasource(request.dsn);

			queryObj.setName("addMentorDtl");
			queryObj.setSQL("
				INSERT INTO sbtbl_td_mentor_dtl (
					main_id,
					sys_key,
					file_provided
				) VALUES (
					:main_id,
					:sys_key,
					:file_provided
				)
			");
			queryObj.addParam(name="main_id",value="#mid#",cfsqltype="cf_sql_numeric");
			queryObj.addParam(name="sys_key",value="#empId#",cfsqltype="cf_sql_varchar");
			queryObj.addParam(name="file_provided",value="#fileProvided#",cfsqltype="cf_sql_integer");
			queryPrefix = queryObj.execute().getPrefix();
			newMainId = queryPrefix.generatedKey;
			queryObj.clearParams();

			queryObj.setName("deleteMentorDtl");
			queryObj.setSQL("
				DELETE FROM sbtbl_td_mentor_dtl
				WHERE	main_id = :main_id
			");
			queryObj.addParam(name="main_id",value="#mid#",cfsqltype="cf_sql_numeric");
			queryObj.execute();
			queryObj.clearParams();

			queryObj.setName("updateMentorMain");
			queryObj.setSQL("
				UPDATE sbtbl_td_mentor_main SET
					start_date = :start_date,
					end_date = :end_date,
					trainer = :trainer,
					editor = :editor,
					modified_date = GETDATE(),
					edit_flag = :edit_flag
				WHERE id = :main_id
			");
			queryObj.addParam(name="start_date",value="#form.start_date#",cfsqltype="cf_sql_date");
			queryObj.addParam(name="end_date",value="#form.end_date#",cfsqltype="cf_sql_date");
			queryObj.addParam(name="trainer",value="#form.trainerId#",cfsqltype="cf_sql_varchar");
			queryObj.addParam(name="editor",value="#session.TD.user.getEmpId()#",cfsqltype="cf_sql_varchar");
			queryObj.addParam(name="edit_flag",value="#form.editFlag#",cfsqltype="cf_sql_varchar");
			queryObj.addParam(name="main_id",value="#mid#",cfsqltype="cf_sql_numeric");
			queryObj.execute();
			queryObj.clearParams();

			queryObj.setName("getCISDtl");
			queryObj.setSQL("
				SELECT	sb_trainer,sb_duration
				FROM	sbtbl_td_course_session
				WHERE	sb_session_id = :cs_id
			");
			queryObj.addParam(name="cs_id",value="#form.csId#",cfsqltype="cf_sql_integer");
			qryCISDtl = queryObj.execute().getResult();
			queryObj.clearParams();

			transaction action="commit";

			writeOutput('
				<script type="text/javascript">
					alert("带教记录更新成功！");
				</script>
			');

		} catch (any e) {
			writeDump(e);
			transaction action="rollback";
		}
	}


	private query function getResponse(required numeric questionNum) {
		queryObj.setName("rtnQuery");
		queryObj.setDBType("query");
		queryObj.setAttributes(questions=allQuestions);
		queryObj.setSQL("
			SELECT	sb_response_num, sb_response
			FROM 	questions
			WHERE	sb_question_num = :question_num
			ORDER BY sb_response_num
		");
		queryObj.addParam(name="question_num",value="#arguments.questionNum#",cfsqltype="cf_sql_integer");
		responses = queryObj.execute().getResult();
		queryObj.clearParams();
		return responses;
	}

</cfscript>