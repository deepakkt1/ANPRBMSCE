%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using ODBC driver.
conn = database('deepak', 'root', '');

%Read data from database.
% curs = exec(conn, ['SELECT 	vehicle.vno,	vehicle.entry ,	vehicle.out, vehicle.type,	vehicle.image FROM 	`vehicledb`.vehicle ']);
% curs = exec(conn,'select * from vehicle');
 curs = exec(conn,'CREATE TABLE ANPRV (vno VARCHAR(50), entry VARCHAR(50),outt VARCHAR(50),typ VARCHAR(50),image TEXT)')
% curso = exec(conn,'Insert into Myvehicle(vno, entry, outt, typ, image) VALUES ("KA12345678","12:00","1:00","bike",123456)')
curso = fetch(curso);

 curs = exec(conn,'select * from Myvehicle');
curs = exec(conn,'update ')
curs = fetch(curs);
curs.Data
% colnames = {'vno','entry','out',...
% 					'type','image'};
% data = {'KA9887665','12:00','1:00','bike',123};
% data_table = cell2table(data,'VariableNames',colnames)
% % curs = exec(conn, ['insert into `vehicledb`.vehicle(`vehicle.vno`,`vehicle.entry`,`vehicle.out`,`vehicle.type`,`vehicle.image`) values (' 'KA ' ' ,' '1' ',' '2 ' ',' 'bike' ', ' '101' ') ']);
% tablename = 'vehicle';
% insert(conn,tablename,colnames,data_table)
% curs = exec(conn,'select * from vehicle');
% curs = fetch(curs);
% curs.Data