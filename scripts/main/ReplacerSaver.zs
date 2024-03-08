import crafttweaker.api.entity.Entity;
import crafttweaker.api.block.Block;
import crafttweaker.api.world.Level;
import crafttweaker.api.world.ServerLevel;
import crafttweaker.api.util.math.BlockPos;
import crafttweaker.api.resource.ResourceLocation;
import crafttweaker.api.data.MapData;
import crafttweaker.api.util.math.Vec3i;
import crafttweaker.api.block.BlockState;
import crafttweaker.api.game.Server;

public class ReplacerSaver{
    private static var blackList as stdlib.List<Block> = new stdlib.List<Block>();
    private static var replaceBlackList as Block[Block] = {};

    public static setBlackList(blocks as Block[]) as void{
        this.blackList = blocks as stdlib.List<Block>;
    }
    public static setReplaceBlackList(replaceBlackList as Block[Block]) as void{
        this.replaceBlackList = replaceBlackList;
    }

    public static clearDate(entity as Entity, saveData as string) as bool{
        if(saveData in entity.customData){
            entity.updateCustomData({saveData as string : "null"});
            return true;
        }
        return false;
    }

    public static saveZone(entity as Entity, x1 as int, y1 as int, z1 as int, x2 as int, y2 as int, z2 as int, saveData as string, server as Server) as void{
        this.clearDate(entity, saveData);
        var blocks as BlockState[BlockPos] = {};
        var level as ServerLevel = entity.level as ServerLevel;
        if(level.isClientSide) return;
        var x as int = x1;
        var y as int = y1;
        var z as int = z1;

        while(x <= x2){
            while(y <= y2){
                while(z <= z2){
                    blocks[new BlockPos(x, y, z)] = this.checkBlock(level, entity.x as int + x, entity.y as int + y, entity.z as int + z);
                    z++;
                }
                y++;
                z = z1;
            }
            x++;
            y = y1;
        }
        this.saveStructure(entity as Entity, blocks, saveData);
    }

    protected static checkBlock(level as ServerLevel, x as int, y as int, z as int) as BlockState{
        if(!this.blackList.isEmpty){
            if(!this.replaceBlackList.isEmpty){
                if((level.getBlockState(new BlockPos(x, y, z)).block in blackList) && (level.getBlockState(new BlockPos(x, y, z)).block in replaceBlackList)){
                    return replaceBlackList[level.getBlockState(new BlockPos(x, y, z)).block].getDefaultState();
                }
            }
            return (level.getBlockState(new BlockPos(x, y, z)).block in blackList) ? <blockstate:minecraft:air> : level.getBlockState(new BlockPos(x, y, z));
        }
        return level.getBlockState(new BlockPos(x, y, z));
    }

    protected static saveStructure(entity as Entity, blocks as BlockState[BlockPos], saveData as string) as void{
        var data as MapData = new MapData();
        var SaveData as MapData = new MapData();
        for pos, block in blocks{
           data.setAt(pos.toShortString, block.getCommandString());
        }
        SaveData.setAt(saveData, data);
        ReplacerFileSaver.save(saveData, SaveData, entity.getStringUUID(), (entity.level as ServerLevel).server);
    }
}