import { $ } from 'bun'

export const sh = command => $`tmux show-options -g ${command}`
