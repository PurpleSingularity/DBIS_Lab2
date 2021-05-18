-- Table Student
create table Student (
   OutId                VARCHAR(64)          not null,
   Birth                INTEGER              null,
   SexTypename          VARCHAR(255)         null,
   RegName              VARCHAR(255)         null,
   AreaName             VARCHAR(255)         null,
   TerName              VARCHAR(255)         null,
   RegTypeName          VARCHAR(255)         null,
   TerTypeName          VARCHAR(255)         null,
   ClassProfileName     VARCHAR(255)         null,
   ClassLangName        VARCHAR(255)         null,
   constraint PK_STUDENT primary key (OutId)
);
create unique index Student_PK on Student (OutId);

-- Table StudyPlace
create table StudyPlace (
	OutId				VARCHAR(64)			not null,
	PlaceID				INTEGER				not null,
	constraint PK_STUDYPLACE primary key (OutId, PlaceID)
);
create unique index StudyPlace_PK on StudyPlace (OutId, PlaceID);

-- Table ZNOResult
create table ZNOResult (
	OutId				VARCHAR(64)			not null,
	SubjectID			VARCHAR(4)			not null,
	PlaceID				INTEGER				not null,
	Lang 				VARCHAR(255)		null,
	TestStatus			VARCHAR(255)		null,
	DPALevel			VARCHAR(255)		null,
	Ball100				INTEGER				null,
	Ball12				INTEGER				null,
	Ball 				INTEGER				null,
	AdaptScale			VARCHAR(255)		null,
	Year				INTEGER				null,
	constraint PK_ZNORESULT primary key (OutID, SubjectID, PlaceID)
);
create unique index ZNOResult_PK on ZNOResult (OutId, SubjectID, PlaceID);

-- Table Subject
create table Subject (
	SubjectID			VARCHAR(4)			not null,
	Subject 			VARCHAR(64)			null,
	constraint PK_SUBJECT primary key (SubjectID)
);
create unique index Subject_PK on Subject (SubjectID);

-- Table Place
create table Place (
	PlaceID				SERIAL				PRIMARY KEY,
	PName 				VARCHAR(1024) 		null,
	TypeName 			VARCHAR(1024) 		null,
	RegName 			VARCHAR(1024) 		null,
	AreaName 			VARCHAR(1024) 		null,
	TerName 			VARCHAR(1024) 		null,
	Parent 				VARCHAR(1024) 		null
);
create unique index Place_PK on Place (PlaceID);

alter table StudyPlace
   add constraint FK_STUDYPLACE_ON_STUDENT foreign key (OutID)
      references Student (OutID)
      on delete restrict on update restrict;

alter table StudyPlace
   add constraint FK_STUDYPLACE_ON_PLACE foreign key (PlaceID)
      references Place (PlaceID)
      on delete restrict on update restrict;

alter table ZNOResult
   add constraint FK_ZNORESULT_ON_STUDENT foreign key (OutID)
      references Student (OutID)
      on delete restrict on update restrict;

alter table ZNOResult
   add constraint FK_ZNOESULT_ON_SUBJECT foreign key (SubjectID)
      references Subject (SubjectID)
      on delete restrict on update restrict;

alter table ZNOResult
   add constraint FK_ZNORESULT_ON_PLACE foreign key (PlaceID)
      references Place (PlaceID)
      on delete restrict on update restrict;