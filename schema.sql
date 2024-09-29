# Load this data into sqlite:
# sqlite3 databasename.db
# .read schema.sql
#
# .schema shows db schema

PRAGMA foreign_keys = ON;

drop table if exists students;
create table students (
    id              integer primary key,
    student_id      text not null,
    student_name    text
);

create index i_students_studentid on students(student_id);

drop table if exists assignments;
create table assignments (
    id              integer primary key,
    description     text,
    starter_code    text
);

drop table if exists tests;
create table tests (
    id              integer primary key,
    assignment_id   integer not null references assignments(id),
    test_info       text,
    expected_result text not null
);

create index i_tests_assignmentid on tests(assignment_id);

drop table if exists autograder_outputs;
create table autograder_outputs (
    id              integer primary key,
    student_id      integer not null references students(id),
    assignment_id   integer not null references assignments(id),
    test_id         integer not null references tests(id),
    output          text not null
);

create index i_autograderoutputs_studenassignmenttest on autograder_outputs(student_id,assignment_id,test_id);

drop table if exists source_codes;
create table source_codes (
    id              integer primary key,
    student_id      integer not null references students(id),
    assignment_id   integer not null references ssignments(id),
    file_path       text not null
);

create index i_sourcecodes_studentassignment on source_codes(student_id,assignment_id);

drop table if exists llm_responses;
create table llm_responses (
    id              integer primary key,
    student_id      integer not null references students(id),
    assignment_id   integer not null references ssignments(id),
    test_id         integer not null references tests(id),
    response_text   text not null
);

create index i_llmresponses_studentassignmenttest on llm_responses(student_id,assignment_id,test_id);

# Test data
#insert into assignments (description, starter_code) values ('test','select 1 from dual');
#insert into tests (assignment_id, test_info, expected_result) values (1, 'crap', 'crap');
#insert into tests (assignment_id, test_info, expected_result) values (94, 'crap','crap');