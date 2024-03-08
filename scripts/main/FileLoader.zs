import mods.sdmcrtplus.utils.file.File;
import mods.sdmcrtplus.utils.file.FileReader;
import mods.sdmcrtplus.utils.file.FileUtils;
import mods.sdmcrtplus.utils.file.Path;
import mods.sdmcrtplus.file.utils.streams.InputStreamReader;
import mods.sdmcrtplus.utils.file.streams.FileInputStream;
import mods.sdmcrtplus.utils.file.streams.BufferedReader;
import mods.sdmcrtplus.utils.file.streams.PrintWriter;
import mods.sdmcrtplus.utils.file.streams.FileInputStream;

import crafttweaker.api.entity.Entity;
import crafttweaker.api.block.Block;
import crafttweaker.api.world.Level;
import crafttweaker.api.world.ServerLevel;
import crafttweaker.api.util.math.BlockPos;
import crafttweaker.api.resource.ResourceLocation;
import crafttweaker.api.data.MapData;
import crafttweaker.api.util.math.Vec3i;
import crafttweaker.api.util.math.Vec3;
import crafttweaker.api.block.BlockState;
import crafttweaker.api.game.Server;
public class ReplacerFileLoader{
    public static var dir as Path = FileUtils.getScriptsDirectory();

    public static load(entity as Entity, name as string, server as Server) as void{
        var level as ServerLevel = entity.level as ServerLevel;
        if(level.isClientSide) return;
        var numList as char[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
        var doint as char[] = ['-', '+'];
        var poslIst as stdlib.List<BlockPos> = new stdlib.List<BlockPos>();
        var meslist as stdlib.List<string> = new stdlib.List<string>();
        var posListBLock as string[BlockPos] = {};
        var block as BlockState = <blockstate:minecraft:air>;

        var listCH as stdlib.List<char> = new stdlib.List<char>();
        var x = "";
        var y = "";
        var z = "";
        try{

            var file = new FileInputStream(FileUtils.getStructureDirectory(server, <resource:sdm:${name}>).toString() + "/" + name + "-" + entity.getStringUUID() + ".snbt");
            var reader = new BufferedReader(new FileReader(FileUtils.getStructureDirectory(server, <resource:sdm:${name}>).toString() + "/" + name + "-" + entity.getStringUUID() + ".snbt"));
            for line in reader.lines(){
                var message as string = "";
                var listPos as string = line as string;
                var count = 0;
                var countCH = 0;
                x = "";
                y = "";
                z = "";

                var bo as char;
                for number in 0 .. line.length{
                    bo = listPos[number] as char;
                    if(bo == ',') count++;

                    if((bo in numList || bo in doint) && count == 0){
                        x += bo;
                        if(x == "" || x == '') x = 0;
                    }
                    
                    if((bo in numList || bo in doint) && count == 1){
                        y += bo;
                        if(y == "" || y == '') y = 0;
                    }

                    if((bo in numList || bo in doint) && count == 2){
                        z += bo;
                        if(z == "" || z == '') z = 0;
                    }
                
                    if(bo == '|') countCH++;
                    if(bo == '<' && countCH == 1) {
                        for num in number .. line.length{
                            bo = listPos[num] as char;
                            if(bo != '>'){
                                message += bo;
                            } if(bo == '>') {
                                posListBLock[new BlockPos(x as int, y as int, z as int)] = message;
                            }
                        }
                    }
                }    
            }

            for pos,messageS in posListBLock{
                if("blockstate" in messageS){
                    var stex as string = messageS as string;
                    var text = "";
                    for blockString in 12 .. stex.length{
                        text += stex[blockString];
                    }
                    if(text == "minecraft:grass_block:snowy=true") text = "minecraft:grass_block";
                    block as BlockState = <blockstate:${text}>;
                    level.setBlockAndUpdate(new BlockPos((entity.x + (pos.x)) as int, (entity.y + (pos.y)) as int, (entity.z + (pos.z)) as int), block);
                }
            }
        }
    }
}