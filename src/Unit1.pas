unit Unit1;

interface

(*
Copyright 2011 Opt-In Software. http://www.optinsoft.com/

This program helps you to recover your jabber password from Miranda IM.

Read more about usage of this program and download compiled version and sources here:
http://www.optinsoft.com/miranda-jabber-password-recovery.php

I built this program using Delphi 7 with Indy 9 library.

You can freely use this program and code for your needs.

Please, don't remove this copyright.
*)

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdTCPServer, ExtCtrls, IdCoderMIME, ShellAPI;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    IdTCPServer1: TIdTCPServer;
    Label2: TLabel;
    Button3: TButton;
    Timer1: TTimer;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label14: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
    fAuthenticationString: String;
    fUser: String;
    fPassword: String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

(*
Copyright 2011 Opt-In Software. http://www.optinsoft.com/

This program helps you to recover your jabber password from Miranda IM.

Read more about usage of this program and download compiled version and sources here:
http://www.optinsoft.com/miranda-jabber-password-recovery.php

I built this program using Delphi 7 with Indy 9 library.

You can freely use this program and code for your needs.

Please, don't remove this copyright.
*)

uses StrUtils;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  IdTCPServer1.DefaultPort := StrToInt(Edit1.Text);
  IdTCPServer1.Active := True;
  Button1.Enabled := False;
  Button2.Enabled := True;
  Edit1.Enabled := False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  IdTCPServer1.Active := True;
  Button1.Enabled := True;
  Button2.Enabled := False;
  Edit1.Enabled := True;
end;

procedure TForm1.IdTCPServer1Execute(AThread: TIdPeerThread);
var
  s, s0, t: String;
  i, k, l, n: Integer;
  bCompleted: Boolean;
  Decoder: TIdDecoderMIME;
  pUser, pPassword: PChar;
begin
  s0 := '';
  n := 0;
  repeat
    s := AThread.Connection.ReadLn('>');
    if Length(s) = 0 then Break;
    s := s +'>';
    s0 := s0 + s;
    for i := 1 to Length(s) do
    begin
      if s[i] = '<' then
        Inc(n)
      else if s[i] = '>' then
        Dec(n);
    end;
    bCompleted := (n <= 0);
    if bCompleted then
    begin
      if (LeftStr(s, 2) = '<?') and
         (RightStr(s, 2) = '?>')
        then bCompleted := False;
    end;
    if bCompleted then
    begin
      if (LeftStr(s, 6) = '<auth ')
        then bCompleted := False;
    end;
  until bCompleted;
  if Pos('<stream:stream ', s0) > 0 then
  begin
    s := '<?xml version=''1.0''?><stream:stream xmlns=''jabber:client'' xmlns:stream=''http://etherx.jabber.org/streams'' '+
      'from=''jabber.org'' id=''1647f61c13930926'' version=''1.0''>'+
      '<stream:features><starttls xmlns=''urn:ietf:params:xml:ns:xmpp-tls''/>'+
      '<mechanisms xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''>'+
//      '<mechanism>CRAM-MD5</mechanism>'+
//      '<mechanism>LOGIN</mechanism>'+
      '<mechanism>PLAIN</mechanism>'+
//      '<mechanism>DIGEST-MD5</mechanism>'+
//      '<mechanism>SCRAM-SHA-1</mechanism>'+
      '</mechanisms>'+
      '<compression xmlns=''http://jabber.org/features/compress''><method>zlib</method></compression>'+
      '<ver xmlns=''urn:xmpp:features:rosterver''>'+
      '<optional/></ver></stream:features>';
    AThread.Connection.Write(s);
  end else
  if Pos('<auth ', s0) > 0 then
  begin
    fAuthenticationString := s0;
    if Pos('mechanism="PLAIN"', s0) > 0 then
    begin
      k := Pos('>', s0);
      if k > 0 then
      begin
        Inc(k);
        l := PosEx('<', s0, k);
        if l > k then
        begin
          s := Copy(s0, k, l-k);
          Decoder := TIdDecoderMIME.Create(nil);
          t := Decoder.DecodeString(s) + #0#0#0;
          pUser := @t[Length(t)];
          pPassword := @t[Length(t)];
          n := 0;
          for i := 1 to Length(t) do
          begin
            if t[i] = #0 then
            begin
              Inc(n);
              if n = 1 then
                pUser := @t[i+1]
              else
              begin
                pPassword := @t[i+1];
                Break;
              end;
            end;
          end;
          fUser := StrPas(pUser);
          fPassword := StrPas(pPassword);
          Decoder.Free;
        end;
      end;
    end;
    AThread.Connection.Disconnect;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fAuthenticationString := '';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Memo1.Text := fAuthenticationString;
  Edit2.Text := fUser;
  Edit3.Text := fPassword;
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open',
    PChar('http://www.optinsoft.com/?referer=jh'),
    nil, nil, SW_SHOWNORMAL);
end;

end.
