Use Windows.pkg
Use DFClient.pkg
Use Util.pkg
Use Empresa.sl

Open EMPRESA
Open CONTATO_EMPRESA
Open ENDERECO_EMPRESA

Deferred_View Activate_oEmpresa for ;
Object oEmpresa is a View
    Set Size to 192 462
    Set Location to 3 4
    Set Label to "Cadastro de Empreendimento/Empresas - SC"
    
    Object oFrmCNPJ is a Form
        Set Label to "CNPJ / CPF:"
        Set Location to 5 143
        Set Size to 13 86
        Set Prompt_Button_Mode to PB_PromptOn
        Set Label_Col_Offset to 138
        
        Procedure Prompt
            Clear EMPRESA
            Send Popup to oEmpresa_sl
            Send pCarregarEmpresa EMPRESA.ID_EMPRESA
        End_Procedure
        
        Procedure Exiting
            String sValor
            
            Move (Trim(Value(Self))) to sValor
            If (sValor <> "") Begin
                If ( (Length(sValor)<>14) and (Length(sValor)<>11) ) Begin
                    Send Info_Box "Tamanho do CNPJ/CPF inválido!" "Aviso"
                    Set Value of Self to ""
                    Procedure_Return
                End
                                
                Clear EMPRESA
                Move sValor to EMPRESA.CNPJ_EMPRESA
                Find eq EMPRESA by 2
                If (Found) Begin
                    Send pCarregarEmpresa EMPRESA.ID_EMPRESA
                End
            End
        End_Procedure
    End_Object

    Object oFrmId is a Form
        Set Label to "Id:"
        Set Location to 5 276
        Set Size to 13 60
        Set Entry_State to False
        Set Enabled_State to False
        Set Label_Col_Offset to 15
        Set Form_Justification_Mode to Form_DisplayRight
    End_Object

    Object oFrmStatus is a ComboForm
        Set Label to "Status:"
        Set Location to 6 397
        Set Size to 13 60
        Set Label_Col_Offset to 25
        Set Combo_Sort_State to False
        Set Entry_State to False

        Procedure Combo_Fill_List
            Send Combo_Add_Item "Ativo"
            Send Combo_Add_Item "Inativo"
        End_Procedure
        
    End_Object

    Object oFrmNome is a Form
        Set Location to 21 143
        Set Size to 13 315
        Set Label to "Nome do empreendimento/empresa:"
        Set Label_Col_Offset to 138
        Set Capslock_State to True
    End_Object

    Object oFrmResponsavel is a Form
        Set Label to "Nome do(a) empreendedor(a) responsável:"
        Set Location to 37 143
        Set Size to 13 315
        Set Label_Col_Offset to 138
        Set Capslock_State to True
    End_Object

    Object oFrmMunicipio is a Form
        Set Label to "Município de Santa Catarina:"
        Set Location to 53 143
        Set Size to 13 160
        Set Label_Col_Offset to 138
        Set Capslock_State to True
    End_Object

    Object oFrmSegmento is a ComboForm
        Set Label to "Segmento:"
        Set Location to 52 343
        Set Size to 13 115
        Set Combo_Sort_State to False
        Set Entry_State to False
        Set Label_Col_Offset to 38
        
        Procedure Combo_Fill_List
            Send Combo_Add_Item ""
            Send Combo_Add_Item "Tecnologia"
            Send Combo_Add_Item "Comércio"
            Send Combo_Add_Item "Indústria"
            Send Combo_Add_Item "Serviços"
            Send Combo_Add_Item "Agronegócio"
        End_Procedure
    End_Object
    
    Object oTabs is a TabDialog
        Set Location to 69 5
        Set Size to 100 454
        Set Rotate_Mode to RM_Rotate
        
        Object oTabEndereco is a TabPage
            Set Label to "Endereço"
            
            Object oFrmCep is a Form
                Set Label to "CEP:"
                Set Location to 3 63
                Set Size to 13 61
                Set Form_Datatype to Mask_Window
                Set Form_Mask to "#####-###"
            End_Object
            
            Object oFrmLogradouro is a Form
                Set Label to "Rua/Av.:"
                Set Location to 19 63
                Set Size to 13 250
                Set Capslock_State to True
            End_Object
            
            Object oFrmNumero is a Form
                Set Label to "Número:"
                Set Location to 35 63
                Set Size to 13 60
            End_Object
            
            Object oFrmBairro is a Form
                Set Label to "Bairro:"
                Set Location to 51 63
                Set Size to 13 250
                Set Capslock_State to True
            End_Object
            
            Object oFrmComplemento is a Form
                Set Label to "Complemento:"
                Set Location to 67 63
                Set Size to 13 250
                Set Capslock_State to True
            End_Object
            
        End_Object
        
        Object oTabContato is a TabPage
            Set Label to "Contato"
            
            Object oFrmEmailContato is a Form
                Set Label to "E-mail:"
                Set Location to 3 63
                Set Size to 13 250
            End_Object
            
            Object oFrmTelefone is a Form
                Set Label to "Telefone:"
                Set Location to 19 63
                Set Size to 13 120
                Set Form_Datatype to Mask_Window
                Set Form_Mask to "(##)####-####"
            End_Object
            
            Object oFrmCelular is a Form
                Set Label to "Celular:"
                Set Location to 35 63
                Set Size to 13 120
                Set Form_Datatype to Mask_Window
                Set Form_Mask to "(##)*####-####"
            End_Object

        End_Object
    
    End_Object
    
    Procedure pCarregarContato Integer iIdEmpresa
        Clear CONTATO_EMPRESA
        Move iIdEmpresa to CONTATO_EMPRESA.ID_EMPRESA
        Find EQ CONTATO_EMPRESA by 2
        If (Found) Begin
            Set Value of oFrmEmailContato to (Trim(CONTATO_EMPRESA.EMAIL))
            Set Value of oFrmTelefone     to (Trim(CONTATO_EMPRESA.TELEFONE))
            Set Value of oFrmCelular      to (Trim(CONTATO_EMPRESA.CELULAR))
        End
        Else Begin
            Set Value of oFrmEmailContato to ""
            Set Value of oFrmTelefone     to ""
            Set Value of oFrmCelular      to ""
        End
    End_Procedure
    
    Procedure pCarregarEndereco Integer iIdEmpresa
        Clear ENDERECO_EMPRESA
        Move iIdEmpresa to ENDERECO_EMPRESA.ID_EMPRESA
        Find EQ ENDERECO_EMPRESA by 2
        If (Found) Begin
            Set Value of oFrmCep          to (Trim(ENDERECO_EMPRESA.CEP))
            Set Value of oFrmLogradouro   to (Trim(ENDERECO_EMPRESA.LOGRADOURO))
            Set Value of oFrmNumero       to (Trim(ENDERECO_EMPRESA.NUMERO))
            Set Value of oFrmBairro       to (Trim(ENDERECO_EMPRESA.BAIRRO))
            Set Value of oFrmComplemento  to (Trim(ENDERECO_EMPRESA.COMPLEMENTO))
        End
        Else Begin
            Set Value of oFrmCep          to ""
            Set Value of oFrmLogradouro   to ""
            Set Value of oFrmNumero       to ""
            Set Value of oFrmBairro       to ""
            Set Value of oFrmComplemento  to ""
        End
    End_Procedure

    Procedure pCarregarEmpresa Integer iId
        Clear EMPRESA
        Move iId to EMPRESA.ID_EMPRESA
        Find EQ EMPRESA by 1
        If (Found) Begin
            Set Value of oFrmId          to (String(EMPRESA.ID_EMPRESA))
            Set Value of oFrmCNPJ        to (Trim(EMPRESA.CNPJ_EMPRESA))
            Set Value of oFrmNome        to (Trim(EMPRESA.NOME_EMPRESA))
            Set Value of oFrmResponsavel to (Trim(EMPRESA.NOME_RESPONSAVEL))
            Set Value of oFrmMunicipio   to (Trim(EMPRESA.MUNICIPIO_SC))
            Set Value of oFrmSegmento    to (GetDescricaoVT(Empresa_Segmento_VT, (Trim(EMPRESA.SEGMENTO))))
            Set Value of oFrmStatus      to (GetDescricaoVT(Empresa_Status_VT, EMPRESA.STATUS))
            
            Send pCarregarEndereco EMPRESA.ID_EMPRESA
            Send pCarregarContato EMPRESA.ID_EMPRESA
        End
        Else Begin
            Send Info_Box "Empresa não encontrada." "Aviso"
        End
    End_Procedure

    Procedure pLimparTela        
        Set Value of oFrmId           to ""
        Set Value of oFrmCNPJ         to ""
        Set Value of oFrmNome         to ""
        Set Value of oFrmResponsavel  to ""
        Set Value of oFrmMunicipio    to ""
        Set Value of oFrmSegmento     to ""
        Set Value of oFrmStatus       to "1"
        Set Value of oFrmCep          to ""
        Set Value of oFrmLogradouro   to ""
        Set Value of oFrmNumero       to ""
        Set Value of oFrmBairro       to ""
        Set Value of oFrmComplemento  to ""
        Set Value of oFrmEmailContato to ""
        Set Value of oFrmTelefone     to ""
        Set Value of oFrmCelular      to ""
        Send Activate to oTabs
        Send Activate to oTabEndereco
        Send Activate to oFrmCNPJ
        Clear EMPRESA
        Clear ENDERECO_EMPRESA
        Clear CONTATO_EMPRESA
    End_Procedure

    Procedure pSalvar
        Integer iNovoID
        String sCNPJ sNome

        Get Value of oFrmCNPJ to sCNPJ
        Get Value of oFrmNome to sNome
        
        If (Trim(sCNPJ) = "") Begin
            Send Info_Box "Informe o CNPJ da empresa." "Validação"
            Send Activate to oFrmCNPJ
            Procedure_Return
        End
        If (Trim(sNome) = "") Begin
            Send Info_Box "Informe o nome da empresa." "Validação"
            Send Activate to oFrmNome
            Procedure_Return
        End

        If (sCNPJ <> "") Begin
            Clear EMPRESA
            Move sCNPJ to EMPRESA.CNPJ_EMPRESA
            Find EQ EMPRESA by 2
            If (not(Found)) Begin
                //Salvar empresa
                Get fProximoIdEmpresa to iNovoID
                Clear EMPRESA
                Move iNovoID                                                            to EMPRESA.ID_EMPRESA
                Move (Trim(Value(oFrmCNPJ)))                                            to EMPRESA.CNPJ_EMPRESA
                Move (Trim(Value(oFrmNome)))                                            to EMPRESA.NOME_EMPRESA
                Move (Trim(Value(oFrmResponsavel)))                                     to EMPRESA.NOME_RESPONSAVEL
                Move (Trim(Value(oFrmMunicipio)))                                       to EMPRESA.MUNICIPIO_SC
                Move (GetValorVT(Empresa_Segmento_VT, (Trim(Value(oFrmSegmento)))))     to EMPRESA.SEGMENTO                    
                Move (GetValorVT(Empresa_Status_VT, Value(oFrmStatus)))                 to EMPRESA.STATUS
                SaveRecord EMPRESA                                                      
                                                                                        
                //Salvar endereco                                                       
                Get fProximoIdEndereco to iNovoID                                       
                Clear ENDERECO_EMPRESA
                Move iNovoID                                                            to ENDERECO_EMPRESA.ID_ENDERECO
                Move EMPRESA.ID_EMPRESA                                                 to ENDERECO_EMPRESA.ID_EMPRESA                                                  
                Move (Trim(Value(oFrmCep)))                                             to ENDERECO_EMPRESA.CEP
                Move (Trim(Value(oFrmLogradouro)))                                      to ENDERECO_EMPRESA.LOGRADOURO
                Move (Trim(Value(oFrmNumero)))                                          to ENDERECO_EMPRESA.NUMERO
                Move (Trim(Value(oFrmBairro)))                                          to ENDERECO_EMPRESA.BAIRRO
                Move (Trim(Value(oFrmComplemento)))                                     to ENDERECO_EMPRESA.COMPLEMENTO
                SaveRecord ENDERECO_EMPRESA                                             
                                                                                        
                //Salvar contatos                                                       
                Get fProximoIdContato to iNovoID                                        
                Clear CONTATO_EMPRESA
                Move iNovoID                                                            to CONTATO_EMPRESA.ID_CONTATO
                Move EMPRESA.ID_EMPRESA                                                 to CONTATO_EMPRESA.ID_EMPRESA
                Move (Trim(Value(oFrmEmailContato)))                                    to CONTATO_EMPRESA.EMAIL
                Move (Trim(Value(oFrmTelefone)))                                        to CONTATO_EMPRESA.TELEFONE
                Move (Trim(Value(oFrmCelular)))                                         to CONTATO_EMPRESA.CELULAR
                SaveRecord CONTATO_EMPRESA
            End
            Else Begin
                Reread EMPRESA
                    Move (Trim(Value(oFrmCNPJ)))                                        to EMPRESA.CNPJ_EMPRESA
                    Move (Trim(Value(oFrmNome)))                                        to EMPRESA.NOME_EMPRESA
                    Move (Trim(Value(oFrmResponsavel)))                                 to EMPRESA.NOME_RESPONSAVEL
                    Move (Trim(Value(oFrmMunicipio)))                                   to EMPRESA.MUNICIPIO_SC
                    Move (GetValorVT(Empresa_Segmento_VT, (Trim(Value(oFrmSegmento))))) to EMPRESA.SEGMENTO
                    Move (GetValorVT(Empresa_Status_VT, Value(oFrmStatus)))             to EMPRESA.STATUS
                    SaveRecord EMPRESA
                Unlock
                
                Clear ENDERECO_EMPRESA 
                Move EMPRESA.ID_EMPRESA to ENDERECO_EMPRESA.ID_EMPRESA
                Find eq ENDERECO_EMPRESA by 2
                If (Found) Begin
                    Reread ENDERECO_EMPRESA
                        Move (Trim(Value(oFrmCep)))                                      to ENDERECO_EMPRESA.CEP
                        Move (Trim(Value(oFrmLogradouro)))                               to ENDERECO_EMPRESA.LOGRADOURO
                        Move (Trim(Value(oFrmNumero)))                                   to ENDERECO_EMPRESA.NUMERO
                        Move (Trim(Value(oFrmBairro)))                                   to ENDERECO_EMPRESA.BAIRRO
                        Move (Trim(Value(oFrmComplemento)))                              to ENDERECO_EMPRESA.COMPLEMENTO
                        SaveRecord ENDERECO_EMPRESA
                    Unlock
                End
                
                Clear CONTATO_EMPRESA 
                Move EMPRESA.ID_EMPRESA to CONTATO_EMPRESA.ID_EMPRESA
                Find eq CONTATO_EMPRESA by 2
                If (Found) Begin
                    Reread CONTATO_EMPRESA
                        Move (Trim(Value(oFrmEmailContato)))                             to CONTATO_EMPRESA.EMAIL
                        Move (Trim(Value(oFrmTelefone)))                                 to CONTATO_EMPRESA.TELEFONE
                        Move (Trim(Value(oFrmCelular)))                                  to CONTATO_EMPRESA.CELULAR
                        SaveRecord CONTATO_EMPRESA
                    Unlock
                End                
            End
            Send Info_Box "Registro salvo." "Sucesso"
        End
        
        Send pLimparTela
    End_Procedure

    Procedure pExcluir
        Integer iId
        Get Value of oFrmId to iId

        If (iId = 0) Begin
            Send Info_Box "Carregue uma empresa para excluir." "Validação"
            Send Activate to oFrmCNPJ
            Procedure_Return
        End

        Clear EMPRESA
        Move iId to EMPRESA.ID_EMPRESA
        Find EQ EMPRESA by 1
        If (Found) Begin
            If (YesNo_Box("Confirma exclusão?", "Atenção", MB_DEFBUTTON2) = MBR_Yes) Begin
                Lock
                    Clear ENDERECO_EMPRESA 
                    Move EMPRESA.ID_EMPRESA to ENDERECO_EMPRESA.ID_EMPRESA
                    Find eq ENDERECO_EMPRESA by 2
                    If (Found) Begin
                        Delete ENDERECO_EMPRESA
                    End
                    
                    Clear CONTATO_EMPRESA 
                    Move EMPRESA.ID_EMPRESA to CONTATO_EMPRESA.ID_EMPRESA
                    Find eq CONTATO_EMPRESA by 2
                    If (Found) Begin
                        Delete CONTATO_EMPRESA
                    End
                    Delete EMPRESA
                Unlock
                Send pLimparTela
            End
        End
    End_Procedure

    Object oBtnSalvar is a Button
        Set Label to "&Salvar"
        Set Location to 171 5
        Set Size to 18 70
        
        Procedure OnClick
            If (YesNo_Box("Deseja salvar?", "Atenção", MB_DEFBUTTON2) = MBR_Yes) Begin
                Send pSalvar
            End
        End_Procedure
    End_Object
    
    Object oBtnLimpar is a Button
        Set Label to "&Limpar"
        Set Location to 171 75
        Set Size to 18 70
        
        Procedure OnClick
            If (YesNo_Box("Deseja limpar a tela?", "Atenção", MB_DEFBUTTON2) = MBR_Yes) Begin
                Send pLimparTela
            End
        End_Procedure
    End_Object

    Object oBtnExcluir is a Button
        Set Label to "E&xcluir"
        Set Location to 171 145
        Set Size to 18 70
        
        Procedure OnClick
            Send pExcluir
        End_Procedure
    End_Object
    
    Object oBtnFechar is a Button
        Set Label to "&Fechar"
        Set Location to 171 215
        Set Size to 18 70
        
        Procedure OnClick
            Send pLimparTela
            Send Close_Panel
        End_Procedure
    End_Object

Cd_End_Object