module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
 networks: {
  	development: {
  		host: "127.0.0.1",
  		port: 7777,
  		network_id: "*"
  	}
  },
  solc: {
      optimizer: {
      enabled: true,
      runs: 200
    }
  }
};
