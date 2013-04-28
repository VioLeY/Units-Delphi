unit Queue;


interface

uses dialogs,sysutils;

type
  TInfo = String;

  PElement = ^TElement;

  TElement = record
    info: TInfo;
    next: PElement;
  end;

  TMyQueue = class
  public
    constructor Create;                       //создание очереди
    destructor  Destroy;                      //очищение
    procedure   Add(i: TInfo);                //добавление элемента в конец очереди
    function    isAviable: boolean;           //проверка на заполненность очереди
    function    Get: TInfo;                   //изъ€тие элемента
    function    GetValue(n:Integer) : TInfo;  //получение значени€ n-ного элемента
    function    GetN(k:integer):TInfo;        //изъ€тие n-ного элемента
    procedure   Delete(n:integer);            //удаление n-ного элемента
    procedure   ShowQueue;
  private
    headQueue:  PElement;
    tailQueue:  PElement;
    procedure   InitQueue;                //инициализаци€
    procedure   FreeQueue;                //освобождение
  end;

implementation

constructor TMyQueue.Create;
begin
  inherited;
  InitQueue;
end;

destructor TMyQueue.Destroy;
begin
  FreeQueue;
  inherited;
end;

procedure TMyQueue.InitQueue;
begin
  headQueue := nil;
  tailQueue := nil;
end;

procedure TMyQueue.FreeQueue;
var
  ok: boolean;
  i: real;
begin
  ok := true;
  while isAviable do
    Get;
end;

procedure TMyQueue.Add(i: TInfo);
var
  p: PElement;
begin
  new(p);
  p.info := i;
  p.next := nil;
  if headQueue = nil then
  begin
    headQueue := p;
    tailQueue := p;
  end
  else
  begin
    headQueue.next := p;
    headQueue := p;
  end;
end;

function TMyQueue.Get: TInfo;
var
  p: PElement;
begin
  if not (Tailqueue=headqueue) then begin
  result := tailQueue.info;
  p := tailQueue;
  tailQueue := tailQueue.next;
  dispose(p);
  end
  else begin
    result:=HeadQueue.info;
    p:=HeadQueue;
    dispose(p);
    HeadQueue:=nil;
    TailQueue:=nil;
  end;
end;

function TMyQueue.GetValue(n:integer):TInfo;
var i:integer;
p : PElement;
begin
  p:=TailQueue;
  if p=nil then result:=''
  else
    for i := 1 to n do
      if i<>n then p:=p.next;
  if p.info<>'' then result:=p.info;
end;

function TMyQueue.isAviable: boolean;
begin
  result := true;
  if tailQueue = nil then
  begin
    result := false;
    exit;
  end;
end;

procedure TMyQueue.ShowQueue;
var
  p: PElement;
  n: integer;
  s: string;
begin
  p := tailQueue;
  while p <> nil do
  begin
    s := s + p.info + ' ';
    p := p.next;
  end;
  ShowMessage(s);
end;

function TMyQueue.GetN(k: Integer):TInfo;
var i:integer;
    p: PElement;
begin
  if k=1 then result:=Get
  else begin
    result:=GetValue(k);
    Delete(k);
  end;
end;

procedure TMyQueue.Delete(n: Integer);
var p,z:PElement; i:integer;
begin
  if n=1 then begin
    new(p);
    p.info:=Get;
    dispose(p);
  end
  else begin
    z:=TailQueue;
    for I := 1 to n-2 do
      z:=z.next;
    p:=z.next;
    z.next:=p.next;
    dispose(p);
  end;

end;

end.
