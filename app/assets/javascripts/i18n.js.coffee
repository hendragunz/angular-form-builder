class I18n
  @_locales =
    'en':
      'save': "Save"
      'delete': "Delete"
      'monthNames': ['January','February','March','April','May','June','July','August','September','October','November','December']
      'monthNamesShort': ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
      'dayNames': ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
      'dayNamesShort': ['Sun','Mon','Tue','Wed','Thu','Fri','Sat']
      'today': 'Today'
      'month': 'Month'
      'week': 'Week'
      'day': 'Day'
      'month_format': 'MMMM yyyy'
      'week_format': "MMM d[ yyyy]{ '&#8212;'[ MMM] d yyyy}"
      'day_format': 'dddd, MMM d, yyyy'
      'column_month_format': 'ddd'
      'column_week_format': 'ddd M/d'
      'column_day_format': 'dddd M/d'
      'loading': 'Loading...'
      'are_you_sure': 'Are you sure?'
      'are_you_sure_this_cannot_be_undone': 'Are you sure? This is definitive'
      'drag_and_drop_here': 'drag and drop here'
      'not_found' : 'not found'
      'create' : 'Create'
      'account_deactivated': "Your account is deactivated. Please update your billing information."
      'account_expired': 'Your account has expired. Please subscribe to continue.'
      'incorrect_number': "The card number is incorrect"
      'invalid_number': "The card number is not a valid credit card number"
      'invalid_expiry_month': "The card's expiration month is invalid"
      'invalid_expiry_year': "The card's expiration year is invalid"
      'invalid_cvc': "The card's security code is invalid"
      'expired_card': "The card has expired"
      'incorrect_cvc': "The card's security code is incorrect."
      'incorrect_zip': "The card's zip code failed validation."
      'card_declined': "The card was declined."
      'missing': "There is no card on a customer that is being charged."
      'processing_error': "An error occurred while processing the card."

      'form':
        'confirm_remove_field': "Are you sure you want to remove, existing data will be deleted as well"
        'content_should_go_in_text_area': 'content should go in text area'

    'fr':
      'save': 'Enregistrer'
      'delete': "Supprimer"
      'monthNames': ['Janvier','Février','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre']
      'monthNamesShort': ['Jan.','Fév.','Mar.','Avr.','Mai','Juin','Juil.','Août','Sept.','Oct.','Nov.','Déc.']
      'dayNames': ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi']
      'dayNamesShort': ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam']
      'today': "Aujourd'hui"
      'month': 'Mois'
      'week': 'Semaine'
      'day': 'Jour'
      'month_format': 'MMMM yyyy'
      'week_format': "d[ yyyy] [MMM]{ '&#8212;' d MMM yyyy}"
      'day_format': 'dddd d MMM yyyy'
      'column_month_format': 'ddd'
      'column_week_format': 'ddd d/M'
      'column_day_format': 'dddd d/M'
      'are_you_sure': 'Êtes-vous sûr?'
      'are_you_sure_this_cannot_be_undone': 'Êtes-vous sûr? Ceci est définitif'
      'drag_and_drop_here': 'glisser déposer ici'
      'not_found' : 'non trouvé'
      'create' : 'Créer'
      'account_deactivated': "Votre compte est désactivé. Merci de mettre à jour vos informations de facturation pour reprendre sans interruption."
      'account_expired': 'Votre compte a expiré. Merci de vous abonner pour poursuivre.'
      'incorrect_number': "Le numéro de carte est incorrect"
      'invalid_number': "Le numéro de carte n'est pas valide"
      'invalid_expiry_month': "Le mois de la date d'expiration n'est pas valide"
      'invalid_expiry_year': "L'année de la date d'expiration n'est pas valide"
      'invalid_cvc': "Le code de sécurité n'est pas valide"
      'expired_card': "Cette carte a expirée"
      'incorrect_cvc': "Le code de sécurité est incorrect"
      'incorrect_zip': "The card's zip code failed validation."
      'card_declined': "La carte a été déclinée"
      'missing': "Il n'y a pas de carte attachée à ce client"
      'processing_error': "Une erreur est survenue"

  @t: (key) ->
    @_locales[CURRENT_LOCALE][key]

@I18n = I18n