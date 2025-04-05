-- Patch open_floating_preview to wrap by word and limit max width
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.max_width = 80 -- Set your desired max width here

  -- Wrap text by word, respecting the max_width
  local wrapped = {}
  local wrap_limit = opts.max_width or 80

  for _, line in ipairs(contents) do
    local current_line = ""
    for word in line:gmatch("%S+") do
      -- If the current line plus the next word exceeds the max_width, wrap it
      if #current_line + #word + 1 > wrap_limit then
        table.insert(wrapped, current_line)
        current_line = word
      else
        -- If it fits, add the word to the current line
        if #current_line > 0 then
          current_line = current_line .. " " .. word
        else
          current_line = word
        end
      end
    end
    -- Insert the final line after the loop
    table.insert(wrapped, current_line)
  end

  -- Show the hover window with the new wrapped lines
  return orig_util_open_floating_preview(wrapped, syntax, opts, ...)
end
