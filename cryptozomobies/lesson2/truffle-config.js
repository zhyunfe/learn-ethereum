module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 9999,
      network_id: "*"
    }
  },
  solc: {
    optimizer: {
      enble: true,
      runs:200
    }
  }
};
