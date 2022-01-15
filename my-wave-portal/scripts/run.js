
const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy({
        value : hre.ethers.utils.parseEther('0.1'),
    });
    await waveContract.deployed();
    console.log("Contract deployed to :", waveContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log('Contract Balance: ',  hre.ethers.utils.formatEther(contractBalance));

    // let wavecount;
    // wavecount = await waveContract.getTotalWaves();
    // console.log(wavecount.toNumber());

    let waveTxn = await waveContract.wave('This is wave #1');
    await waveTxn.wait();
  
    waveTxn = await waveContract.wave('This is wave #2');
    await waveTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log('Contract Balance: ',  hre.ethers.utils.formatEther(contractBalance));

    // const [owner, randoPerson] = await ethers.getSigners();
    // waveTxn = await waveContract.connect(randoPerson).wave('Another message');
    // await waveTxn.wait();

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();