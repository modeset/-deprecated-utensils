
#= require utensils/utensils

class utensils.Timeslot

  constructor: () ->
    @active_key_types = /^active|^show|^on|^in|^start|^first|^enable|^open/
    @deactive_key_types = /^deactive|^hid|^off|^out|^end|^last|^disable|^fade|^close/

  getTimeslotFromData: (delay, active_key="activate", deactive_key="deactivate") ->
    data = {}

    if !delay
      active_val = 0
      deactive_val = 0

    else if delay && typeof delay == 'number'
      active_val = delay
      deactive_val = delay

    else
      key_matcher = /[a-zA-Z]/g
      val_matcher = /\d+/g
      params = delay.split(',')

      match_1 = params[0].match(key_matcher)
      match_2 = params[1].match(key_matcher)

      active_key = if match_1 then match_1.join().replace(/,|\s/g, '') else active_key
      deactive_key = if match_2 then match_2.join().replace(/,|\s/g, '') else deactive_key
      val_1 = parseInt(params[0].match(val_matcher), 10)
      val_2 = parseInt(params[1].match(val_matcher), 10)

      active_val = val_1
      deactive_val = val_2

    data[active_key] = active_val
    data[deactive_key] = deactive_val

    # Add the standard activate/deactivate values for future use
    if active_key != 'activate'
      data[@getClosestMatch(active_key, 0)] = active_val
    if deactive_key != 'deactivate'
      data[@getClosestMatch(deactive_key, 1)] = deactive_val

    return data

  getClosestMatch: (key_name, index=0) ->
    if key_name.match(@active_key_types)
      return 'activate'
    else if key_name.match(@deactive_key_types)
      return 'deactivate'
    else if index == 0
      return 'activate'
    else
      return 'deactivate'

