local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-jar',
    vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_mac',
    '-data',
    workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },

  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all', -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
    },
  },

  init_options = {
    bundles = {},
  },
}
require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract Variable' })
vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })

--vim.api.nvim_set_keymap('n', '<leader>cr', ':botright 10split | resize 10 | terminal mvn clean package -q -DskipTests && java -jar target/*.jar<CR>:wincmd p<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>cr', ':lua build_and_run()<CR>', { noremap = true, silent = true })


-- Function to close all terminal buffers
function close_all_terminals()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
end


function build_and_run()
    close_all_terminals()

    -- Otevře nový terminál a spustí build + run
    vim.cmd("botright 10split | resize 10 | terminal mvn clean package -q -DskipTests && java -jar target/*.jar")

    -- Přepne do insert módu (automatické scrollování)
    vim.cmd("startinsert")

    -- Vrátí se zpět do původního okna
    vim.cmd("wincmd p")
end

-- Mapping <leader>t to close all terminal buffers
vim.api.nvim_set_keymap('n', '<leader>cc', ':lua close_all_terminals()<CR>', { noremap = true, silent = true })

-- Funkce pro spuštění Maven v pozadí a sledování jeho stavu
function run_maven_in_background()
    -- Zpráva o zahájení build procesu
    print("Maven build is starting...")

    -- Spuštění Maven příkazu v pozadí
    local job_id = vim.fn.jobstart("mvn package -q -DskipTests", {
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                print("Maven build completed successfully!")
            else
                print("Maven build failed with exit code: " .. exit_code)
            end
        end,
        stdout_buffered = true,
        stderr_buffered = true,
    })
    
    if job_id == 0 then
        print("Failed to start Maven build job.")
    end
end

-- Přiřazení klávesové zkratky <leader>b pro spuštění funkce
vim.api.nvim_set_keymap('n', '<leader>ca', ':lua run_maven_in_background()<CR>', { noremap = true, silent = true })

