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
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QueryVeiculodescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 50
    end
    object QueryVeiculoplaca: TStringField
      DisplayLabel = 'Placa'
      FieldName = 'placa'
      Origin = 'placa'
      Size = 6
    end
    object QueryVeiculoTipoCombustivel: TStringField
      DisplayLabel = 'Tipo de Combustivel'
      FieldName = 'TipoCombustivel'
      Origin = 'TipoCombustivel'
      Size = 1
    end
    object QueryVeiculocapacidadetanque: TCurrencyField
      DisplayLabel = 'Capacidade do Tanque'
      FieldName = 'capacidadetanque'
      Origin = 'capacidadetanque'
    end
    object QueryVeiculomediaconsumo: TCurrencyField
      DisplayLabel = 'M'#233'dia de Consumo'
      FieldName = 'mediaconsumo'
      Origin = 'mediaconsumo'
    end
    object QueryVeiculovalorcombustivel: TCurrencyField
      DisplayLabel = 'Valor do Combust'#237'vel'
      FieldName = 'valorcombustivel'
      Origin = 'valorcombustivel'
    end
  end
end
