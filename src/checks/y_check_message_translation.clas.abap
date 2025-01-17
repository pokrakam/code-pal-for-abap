CLASS y_check_message_translation DEFINITION PUBLIC INHERITING FROM y_check_base CREATE PUBLIC .
  PUBLIC SECTION.
    METHODS constructor.

  PROTECTED SECTION.
    METHODS inspect_tokens REDEFINITION.

ENDCLASS.


CLASS y_check_message_translation IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).

    settings-pseudo_comment = '"#EC MSG_TRANSL'.
    settings-disable_threshold_selection = abap_true.
    settings-threshold = 0.
    settings-documentation = |{ c_docs_path-checks }message-translation.md|.

    set_check_message( 'Make the Message Translatable!' ).
  ENDMETHOD.


  METHOD inspect_tokens.
    CHECK statement-type = scan_stmnt_type-standard.
    CHECK get_token_abs( statement-from ) = 'MESSAGE'.
    CHECK ref_scan_manager->tokens[ statement-from + 1 ]-type = scan_token_type-literal.

    DATA(configuration) = detect_check_configuration( statement ).

    IF configuration IS INITIAL.
      RETURN.
    ENDIF.

    raise_error( statement_level = statement-level
                 statement_index = index
                 statement_from  = statement-from
                 error_priority  = configuration-prio ).
  ENDMETHOD.

ENDCLASS.
