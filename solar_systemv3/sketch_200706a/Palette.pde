class palette_color{
    
    public  color[] sun = {
        #ffff00,#fff800,#fff100,#ffeb00,#ffe400,#ffdd00,#ffd600,#ffcf00,#ffc700,
        #ffc000,#ffb900,#ffb200,#ffaa00,#ffa200,#ff9a00,#ff9200,#ff8a00,#ff8100,
        #ff7800,#ff6e00,#ff6400,#ff5900,#ff4c00,#ff3e00,#ff2a00
    };  
  
    public color[] mercury = {
        #000000,#0b0501,#140b03,#1a0f04,#1f1305,#241607,#2a1908,#2f1c09,#341f0a,
        #3a220b,#40250b,#45280c,#4b2b0c,#512e0c,#57310c,#5d340b,#64380b,#6a3b0a,
        #703e0a,#764109,#7d4508,#834806,#8a4b05,#904f04,#975202
    };
  
  
    public color[] venus = {
        #5c1b00,#642300,#6d2a00,#753100,#7e3900,#864000,#8f4800,#984f00,#a05700,
        #a95f00,#b26601,#ba6f04,#c37708,#cb800b,#d3880f,#dc9112,#e49916,#eca21a,
        #f5ab1d,#feb421,#fdc045,#fbcc6d,#fad791,#f8e1b4,#f7ebd5
    };  
  
  
    public color[] earth =
    {//earth like
        #00429d, #0c469d, #144a9d,#295d9b, #2c619b, #2f659b, #31699b, #336d9a, #34719a,
        #36759a, #377999, #387e99, #6cca6c, #69c567, #66c161, #65bd5b, #64b856, #63b350,
        #64af4b, #64aa46, #66a541, #67a03c, #699b37, #6b9633, #6e912e, #708b29, #738625,
        #768021, #787a1c, #7b7518, #7e6f14, #816810, #84620c, #875b07, #895304, #8c4c02, 
        #8f4300
    };
    
    public color[] moon = {
        #2e2e2e,#353535,#3c3c3c,#434343,#4a4a4a,#515151,#595959,#606060,#686868,#6f6f6f,
        #777777,#7f7f7f,#878787,#8f8f8f,#979797,#9f9f9f,#a8a8a8,#b0b0b0,#b8b8b8,#c1c1c1,
        #c9c9c9,#d2d2d2,#dbdbdb,#e3e3e3,#ececec
    };
    
    public color[] mars = {
        #c07100,#be6e00,#bc6c00,#ba6900,#b86700,#b66400,#b46100,#b25f00,#b15c00,#af5a00,
        #ad5700,#ab5400,#a95200,#a74f00,#a54c00,#a34a00,#a14700,#9f4400,#9d4200,#9b3f00,
        #993c00,#973900,#963700,#943400,#923100
    };
    
    public color[] jupiter = {
        #ffc460,#fbbe5c,#f6b858,#f2b254,#eeac50,#e9a54c,#e59f48,#e19944,#dc9340,#d88e3c,
        #d38838,#cf8235,#ca7c31,#c6762d,#c27029,#bd6a25,#b96422,#b45e1e,#b0581a,#ab5316,
        #a74d12,#a2470e,#9d410a,#993b06,#943403
    };
    
    public color[] saturn = {
        #ffc460,#febe5c,#fcb858,#fbb254,#f9ac50,#f8a64c,#f6a048,#f49a45,#f29441,#f18e3d,
        #ef8839,#ed8235,#eb7b31,#e9752e,#e76f2a,#e56826,#e26122,#e05a1f,#de531b,#db4c17,
        #d94413,#d73b0f,#d4320b,#d12706,#cf1903
    };
    
    public color[] uranus = {
        #01343f,#093b46,#11424d,#194955,#21505c,#2a5864,#325f6b,#3a6773,#436e7b,#4b7682,
        #547d8a,#5c8592,#648d9a,#6c96a3,#749eab,#7ca6b3,#84aebc,#8cb7c4,#95bfcd,#9dc8d6,
        #a6d0de,#b6d8e3,#c6dfe7,#d6e6ec,#e5eef0
    };
    
    public color[] neptune = {
        #003b5e,#004266,#00496d,#005175,#00587d,#006085,#00688e,#007096,#00789e,#0080a7,
        #0188af,#0390b7,#0699bf,#09a1c7,#0caad0,#0fb2d8,#12bbe0,#15c4e9,#18ccf2,#1bd5fa,
        #38defe,#6be4fb,#94e9f9,#b8edf8,#d8f1f6
    };
    
    public color[] disk1 = {};
    
    public color[][] forRng = {sun, mercury, venus, earth, moon,  mars, jupiter, saturn, uranus, neptune}; 
    
    public color[] getPaletteByName(String name){
      color[] res = null;
      switch(name){
        case "sun" :
          res = this.sun;
          break;
        case "mercury":
          res = this.mercury;
          break;
        case "venus":
          res = this.venus;
          break;
        case "earth_planet":
          res = this.earth;
          break;
        case "earth_moon":
          res = this.moon;
          break;
        case "mars":
          res = this.mars;
          break;
        case "jupiter":
          res = this.jupiter;
          break;
        case "saturn":
          res = this.saturn;
          break;
        case "uranus":
          res = this.uranus;
          break;
        case "neptune":
          res = this.neptune;
          break;
        default:
          res = forRng[(int)random(forRng.length-1)];
          break;
      }
      return res;
    
    }
  
}
