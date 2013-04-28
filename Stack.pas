unit Stack;


interface

uses Dialogs;

type
  TInfo = integer;
  PElement = ^TElement;

  TElement = record
    next: PElement;
    info: TInfo;
  end;

  TMyStack = class
  public
    constructor Create;
    destructor Destroy;
    procedure Put(i: TInfo);
    function Pop: TInfo;
    function isEmpty: boolean;
  private
    head: PElement;
    procedure InitStack;
    procedure FreeStack;
  end;

implementation

constructor TMyStack.Create;
begin
  inherited;
  InitStack;
end;

destructor TMyStack.Destroy;
begin
  FreeStack;
  inherited;
end;


procedure TMyStack.InitStack;
begin
  FreeStack;
  head := nil;
end;

procedure TMyStack.FreeStack;
var
  p, q: PElement;
begin
  p := head;
  while p <> nil do
  begin
    q := p;
    p := p.next;
    dispose(q);
  end;
end;


procedure TMyStack.Put(i: AnsiChar);
var
  p: PElement;
begin
  new(p);
  p.info := i;
  p.next := head;
  head := p;
end;

function TMyStack.Pop: TInfo;
var
  p: PElement;
begin
  p := head;
  result := p.info;
  head := head.next;
  dispose(p);
end;

function TMyStack.isEmpty: boolean;
begin
  result := head = nil;
end;


end.
