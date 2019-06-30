-- A small library to manage midi input and output parameters.

local Midi_Device_Helper = { devices = {}, input = nil, output = nil }

Midi_Device_Helper.init = function(self)
  -- Get a list of midi devices
  for id,device in pairs(midi.vports) do
    print('Midi Device Helper','Found device: '..device.name)
    self.devices[id] = device.name
  end
  -- Create Params
  params:add{type = "option", id = "midi_output", name = "Midi Output", options = self.devices, default = 1, action=self.set_output}
  params:add{type = "option", id = "midi_input", name = "Midi Input", options = self.devices, default = 2, action=self.set_input}
  params:add_separator()
  Midi_Device_Helper.set_output()
  Midi_Device_Helper.set_input()
end

Midi_Device_Helper.get_output_name = function(self)
  return self.devices[params:get("midi_output")]
end

Midi_Device_Helper.get_input_name = function(self)
  return self.devices[params:get("midi_input")]
end

Midi_Device_Helper.set_output = function(x)
  print('Midi Device Helper','Set output device: '..Midi_Device_Helper:get_output_name())
  Midi_Device_Helper.output = midi.connect(params:get("midi_output"))
end

Midi_Device_Helper.set_input = function(x)
  print('Midi Device Helper','Set input device: '..Midi_Device_Helper:get_input_name())
  Midi_Device_Helper.input = midi.connect(params:get("midi_input"))
end

Midi_Device_Helper.on_input = function(self,fn)
  if self.input == nil then print('Midi Device Helper','Missing Input Device') ; return end
  if self.input.event then
    self.input.event = nil
  end
  self.input.event = fn
end

Midi_Device_Helper.on_output = function(self,fn)
if self.output == nil then print('Midi Device Helper','Missing Output Device') ; return end
  if self.output.event then
    self.output.event = nil
  end
  self.output.event = fn
end

return Midi_Device_Helper