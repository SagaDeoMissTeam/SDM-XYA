import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.data.MapData;
import stdlib.List;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.DoubleData;
import crafttweaker.api.item.IItemStack;

import crafttweaker.api.world.Container;
import mods.rpgworld.utils.CustomRandom;
import mods.crtultimate.math.Random;
import crafttweaker.api.entity.type.player.Inventory;

import mods.sdmcrtplus.integration.ftbquest.FTBUtils;
import mods.sdmcrtplus.integration.ftbquest.BaseQuestFile;
import mods.sdmcrtplus.integration.ftbquest.TeamData;


public class QuestUtils{
    public val player as Player;
    public val teamData as TeamData;
    public val questFile as BaseQuestFile = FTBUtils.getQuestFile() as BaseQuestFile;

    public this(player as Player){
        this.player = player;
        this.teamData = FTBUtils.getData(player);
    }

    public static of(player as Player) as QuestUtils{
        return new QuestUtils(player);
    }

    public isComplete(id as string) as bool{
        return questFile.getObject(FTBUtils.parseQuestCodeString(id)).isCompletedRaw(teamData);
    }

    public setComplete(id as string) as void{
        teamData.setCompleted(FTBUtils.parseQuestCodeString(id));
    }
}