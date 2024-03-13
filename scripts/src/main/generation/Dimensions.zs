
import stdlib.List;
import crafttweaker.api.util.math.BlockPos;
import crafttweaker.api.entity.Entity;
import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.entity.type.player.ServerPlayer;
import crafttweaker.api.entity.LivingEntity;
import crafttweaker.api.world.Level;
import crafttweaker.api.game.Server;
import crafttweaker.api.world.ServerLevel;
import crafttweaker.api.resource.ResourceLocation;

public class Dimensions{
    public static val dimensionsList as Dimension[string] = {};
    public static val valdimensionsList2 as List<Dimension> = new List<Dimension>();

    public static init() as void{
        register("minecraft:overworld");
        register("minecraft:the_end");
        register("minecraft:the_nether");
        register("shadowlands:blood_forest");
        register("shadowlands:glowshroom_forest");
        register("shadowlands:shadow_forest");
        register("shadowlands:vellium");
        register("unseen_world:the_darkness");
    }

    public static register(dim as string) as string{
        dimensionsList[dim] = new Dimension(dim);
        valdimensionsList2.add(new Dimension(dim));
        return dim;
    }

    public static randomTeleport(entity as Entity) as void{
        var level = entity.level;
        var random = level.random;
        var dim as Dimension = valdimensionsList2[random.nextInt(valdimensionsList2.length as int)];
        dim.teleport(entity);
    }
}

public class Dimension{
    public var id as string;
    public var pos as BlockPos;
    public this(id as string){
        this.id = id;
        this.pos = new BlockPos(34,38,-75);
    }
    public this(id as string, pos as BlockPos){
        this.id = id;
        this.pos = pos;
    }

    public teleport(entity as Entity) as void{
        if(entity is Player){
            val player as ServerPlayer = entity as Player as ServerPlayer;
            val level as ServerLevel = player.level as ServerLevel;
            val server as Server = level.server as Server;
            var sleepPos as BlockPos? = player.getRespawnPosition() as BlockPos?;
            var respawnPos as BlockPos = new BlockPos(0,0,0);
            var respawnDim as ResourceLocation = <resource:${id}>;
            val playerRespawnDimension as ResourceLocation = player.getRespawnDimensionRegistryName() as ResourceLocation;
            if(sleepPos == null) {
                respawnPos = pos;
            } else respawnPos = sleepPos;
            val spawnDimensionLevel as ServerLevel? = server.getLevel(<resource:${respawnDim}>) as ServerLevel?;
            if(spawnDimensionLevel != null){

                if(playerRespawnDimension != <resource:${respawnDim}>){
                    respawnDim = <resource:${id}>;
                    player.setRespawnPosition(spawnDimensionLevel, respawnPos);
                }

                player.teleportTo(spawnDimensionLevel, respawnPos);
                //clearZone(level, respawnPos);
                server.executeCommand("execute in " + id + " run spawnpoint " + player.displayName.getString() + " " + respawnPos.x + " " + respawnPos.y + " " + respawnPos.z, true);
                return;
            }

            println("[SDM ERRORS] Dimension Not Found");
        }
    }

    public clearZone(level as ServerLevel, pos as BlockPos) as void{
        var x as int = pos.x - 3;
        var y as int = pos.y - 3;
        var z as int = pos.z - 3;
        while(x <= pos.x + 3){
            while(y <= pos.y + 3){
                while(z <= pos.z  + 3){
                    level.destroyBlock(new BlockPos(x,y,z), false);
                    z++;
                }
                y++;
                z = pos.z - 3;
            }
            x++;
            y = pos.x - 3;
        }
    }
}