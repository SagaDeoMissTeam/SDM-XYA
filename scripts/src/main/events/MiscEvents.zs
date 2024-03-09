import crafttweaker.forge.api.event.item.ItemTooltipEvent;
import stdlib.List;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.entity.type.player.Player;
import crafttweaker.api.text.Component;
import crafttweaker.api.data.MapData;
import mods.rpgworld.events.ScreenCloseEvent;

/*----------------------------------------------------------------
                Класс не определённых событий
------------------------------------------------------------------*/
public class MiscEvents {

    protected static onItemTooltipEvent() as void{
    }

    protected static onDifficultSelectedEvent() as void{
        events.register<mods.rpgworld.events.DifficultSelectedEvent>(event => {
            val player = event.entity;
            if(player.level.isClientSide) return;
            println(player.customData as string);


            var state = PlayerStateMachine.of(player);
            state.generateBaseStats();
            state.syncData();
            if(!("havePlaing" in player.customData)){
                player.updateCustomData({"havePlaing" : true});
            }
            player.sendMessage(player.customData as string);
            println(player.customData as string);
            PlayerDataBase.of(player).serialize();
            PlayerPropertyUtils.of(player).run();
        });
    }

    protected static onScreenCloseEvent() as void{
        events.register<mods.rpgworld.events.ScreenCloseEvent>(event => {
            var player = event.entity;
            if(player.level.isClientSide) return;

            var state = PlayerStateMachine.of(player);
            state.generateBaseStats();
            state.syncData();
        });
    }

    public static init() as void{
        onDifficultSelectedEvent();
        onScreenCloseEvent();
        onItemTooltipEvent();
    }
}