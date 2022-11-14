object dm: Tdm
  OldCreateOrder = False
  Height = 476
  Width = 672
  object QueryPessoa: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select'
      '  *'
      'from pessoa'
      ''
      '')
    Left = 104
    Top = 16
    object QueryPessoaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QueryPessoanome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 40
    end
    object QueryPessoacpf: TStringField
      FieldName = 'cpf'
      Origin = 'cpf'
      Size = 11
    end
    object QueryPessoacelular: TStringField
      FieldName = 'celular'
      Origin = 'celular'
      Size = 13
    end
    object QueryPessoacep: TStringField
      FieldName = 'cep'
      Origin = 'cep'
      Size = 10
    end
    object QueryPessoaendereco: TStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 60
    end
    object QueryPessoacidade: TStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 60
    end
    object QueryPessoauf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
    object QueryPessoabairro: TStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 60
    end
    object QueryPessoaemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 60
    end
    object QueryPessoasenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 40
    end
    object QueryPessoaimg_usuario: TBlobField
      FieldName = 'img_usuario'
      Origin = 'img_usuario'
    end
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\F'#225'bio\Documents\Embarcadero\Studio\Projects\Ap' +
        'pViagem\database\RouteApp.db'
      'SharedCache=10000'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = FDConnectionAfterConnect
    BeforeConnect = FDConnectionBeforeConnect
    Left = 32
    Top = 16
  end
  object QueryVeiculo: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select'
      '  *'
      'from veiculo'
      ''
      '')
    Left = 176
    Top = 16
    object QueryVeiculoid: TFDAutoIncField
      DisplayLabel = 'Id'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object QueryVeiculodescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 50
    end
    object QueryVeiculoPlaca: TStringField
      FieldName = 'Placa'
      Origin = 'Placa'
      Size = 6
    end
    object QueryVeiculotipocombustivel: TStringField
      DisplayLabel = 'Combust'#237'vel'
      FieldName = 'tipocombustivel'
      Origin = 'tipocombustivel'
      Visible = False
      Size = 1
    end
    object QueryVeiculocapacidadetanque: TCurrencyField
      DisplayLabel = 'Capacidade'
      FieldName = 'capacidadetanque'
      Origin = 'capacidadetanque'
      Visible = False
    end
    object QueryVeiculomediaconsumo: TCurrencyField
      DisplayLabel = 'M'#233'd. Consumo'
      FieldName = 'mediaconsumo'
      Origin = 'mediaconsumo'
      Visible = False
    end
  end
end
