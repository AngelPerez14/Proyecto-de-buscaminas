program Buscaminas;
uses crt;

const
  facilN = 8; //tamaño del area de juego
  facilM = 10; //numero de minas del nivel facil

  medioN = 16;//tamaño del area del juego del nivel medio
  medioM = 40;//numero de minas del nivel medio

  dificilN = 24;//tamaño del area del juego del nivel dificil
  dificilM = 99;//numero de minas del nivel dificil

type
  tablero = array[1..dificilN, 1..dificilN] of integer;
  estadoCelda = array[1..dificilN, 1..dificilN] of boolean;

var
  T: tablero;
  E: estadoCelda;
  i, j, k, x, y: integer;
  fila, columna: integer;
  FinJuego: boolean;
  nombre: string;

procedure inicializarTablero(N, M: integer);
begin
  randomize;
  for i := 1 to N do
    for j := 1 to N do
      T[i, j] := 0;

  for k := 1 to M do
  begin
    repeat
      x := random(N) + 1;
      y := random(N) + 1;
    until T[x, y] = 0;

    T[x, y] := 9;
	
    for i := x - 1 to x + 1 do
      for j := y - 1 to y + 1 do
        if (i in [1..N]) and (j in [1..N]) and (T[i, j] <> 9) then
          inc(T[i, j]);
  end;
end;

procedure mostrarTablero(N: integer);
begin
  clrscr;
  textcolor(lightblue);
  writeln('---------------------------------');
  writeln('Jugador: ', nombre);
  writeln('---------------------------------');
  for i := 1 to N do
  begin
  textcolor(lightcyan);
    for j := 1 to N do
      if not E[i, j] then
        write('X ')
      else if T[i, j] = 9 then
        write('* ')
      else
        write(T[i, j], ' ');
    writeln;
  end;
end;

procedure jugar(N, M: integer);
var
  opcion: char;
begin
  mostrarTablero(N);
  writeln;
  writeln('Introduce la columna y la fila que quieres revelar:');
  readln(fila, columna);
  if (fila in [1..N]) and (columna in [1..N]) then
  begin
    E[fila, columna] := true;
    if T[fila, columna] = 9 then
    begin
    textcolor(red);
      writeln('Has perdido encontraste una mina');

      repeat
        writeln('Quieres volver a intentarlo? (1 = Si, 0 = No)');
        readln(opcion);
      until (opcion = '1') or (opcion = '0');

      if opcion = '0' then
        FinJuego := true
      else
      begin
        inicializarTablero(N, M);
        for i := 1 to N do
          for j := 1 to N do
            E[i, j] := false;
        FinJuego := false;
      end;
    end
    else
    begin
      writeln('Has revelado la celda ', fila, ',', columna, ' que tiene ', T[fila, columna], ' minas adyacentes, PRESIONE ENTER');
    end;
  end
  else
  begin
    writeln('Introduce una columna y una fila valida');
  end;
  readln;
end;

begin
	textcolor(lightblue);
	writeln('----------------------------');
    writeln('Ingrese su nick de jugador: ');
    writeln('----------------------------');
    readln(nombre);
	clrscr;
  repeat
    writeln('-----------------------------------');
    writeln('Seleccione el nivel de dificultad:');
    writeln('1. Facil');
    writeln('2. Medio');
    writeln('3. Dificil');
    writeln('-----------------------------------');
    readln(i);

    case i of
      1: begin
           inicializarTablero(facilN, facilM);
           mostrarTablero(facilN);
         end;
      2: begin
           inicializarTablero(medioN, medioM);
           mostrarTablero(medioN);
         end;
      3: begin
           inicializarTablero(dificilN, dificilM);
           mostrarTablero(dificilN);
         end;
    else
      begin
        writeln('Opcion invalida.');
        continue;
      end;
    end;

    FinJuego := false;
    while not FinJuego do
    begin
      jugar(i, facilM);
    end;

  until FinJuego;
  writeln('GRACIAS POR JUGAR ;)');
end.

