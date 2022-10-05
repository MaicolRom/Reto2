create database DBReto
go

use DBReto
go

create table Libros(
codigo varchar(5),
titulo varchar(40),
autor varchar(30),
editorial varchar(20),
precio decimal(5,2),
cantidad smallint,
primary key(codigo)
  )  
go

---LISTAR---
create proc sp_listar
as
select * from Libros order by codigo
go

--BUSCAR--
create proc sp_buscar
@titulo varchar(50)
as
select codigo,titulo,autor,editorial,precio,cantidad from Libros where titulo like @titulo + '%'
go

create proc sp_mantenimiento
@codigo varchar(5),
@titulo varchar(40),
@autor varchar(30),
@editorial varchar(20),
@precio decimal(5,2),
@cantidad smallint,
@accion varchar(50) output
as
if (@accion='1')
begin
	declare @codnuevo varchar(5), @codmax varchar(5)
	set @codmax = (select max(codigo) from Libros)
	set @codmax = isnull(@codmax,'A0000')
	set @codnuevo = 'A'+RIGHT(RIGHT(@codmax,4)+10001,4)
	insert into Libros(codigo,titulo,autor,editorial,precio,cantidad)
	values(@codnuevo,@titulo,@autor,@editorial,@precio,@cantidad)
	set @accion='Se genero el código: ' +@codnuevo
end
else if (@accion='2')
begin
	update Libros set titulo=@titulo,autor=@autor,editorial=@editorial,precio=@precio,cantidad=@cantidad where codigo=@codigo
	set @accion='Se modifico el código: ' +@codigo
end
else if (@accion='3')
begin
	delete from Libros where codigo=@codigo
	set @accion='Se borro el código: ' +@codigo
end




