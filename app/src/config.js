const _ = require('lodash')

let port0 = 18190
let port1 = 18191
let port2 = 18891

if (process.platform === 'darwin') {
  port0 = 9090
  port1 = 9090
  port2 = 9090
}

const config = {
  network: {
    from: 'SbN3vwsPjpdoiQxVJBua7gTez39Vmsjhzp',
    privateKey: '65b0799156e773d8d44d32769770d401d4c80f081ca3ee98fe137d46b16f9c17',
    consume_user_resource_percent: 30,
    fee_limit: 100000000,
    fullNode: `http://127.0.0.1:${port0}`,
    solidityNode: `http://127.0.0.1:${port1}`,
    eventServer: `http://127.0.0.1:${port2}`,
    network_id: "*"
  },
  env: [
      'showBody',
      'showQueryString',
      'verbose',
      'quiet',
      'useDefaultPrivateKey',
      'accounts',
      'mnemonic',
      'hdPath',
      'seed',
      'addAccounts',
      'formatJson',
      'defaultBalance'
  ],
  getEnv: (env = process.env) => {
      env = _.pick(env, config.env)
      for (let key in env) {
        if (env[key] === 'false') {
          env[key] = false
        } else if (env[key] === 'true') {
          env[key] = true
        } else if (env[key] === parseInt(env[key]).toString()) {
          env[key] = parseInt(env[key])
        }
      }
      if (typeof env.accounts !== 'number') env.accounts = 10
      if (!process.env.quiet || process.env.verbose === 'verbose') {
        env.verbose = true
      }
      return env
  }
}

module.exports = config