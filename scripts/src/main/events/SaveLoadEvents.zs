import mods.crtultimate.events.server.ServerStartedEvent;
import mods.crtultimate.events.server.ServerStoppedEvent;
import mods.sdmengine.snbt.SNBT;
import mods.sdmengine.snbt.SDMCompoundTag;
import mods.sdmengine.snbt.SNBTCompoundTag;

public class SaveLoadEvents{

    protected static onServerStartedEvent() as void{
        events.register<mods.crtultimate.events.server.ServerStartedEvent>(event => {
            Developers.deserialize();
            var data as SDMCompoundTag? = ModpackDataUtils.readDataWithName("loreData.snbt");
            if(data != null) LoreManager.deserialize(data.getMapData());
        });
    }

    protected static onServerStoppedEvent() as void{
        events.register<mods.crtultimate.events.server.ServerStoppedEvent>(event => {
            Developers.serialize();
            var data as SDMCompoundTag = SDMCompoundTag.of(LoreManager.serialize()) as SDMCompoundTag;
            ModpackDataUtils.saveDataWithName("loreData.snbt", data);
            ModpackDataUtils.saveGlobalData("/loreData.snbt", data);
        });
    }

    public static init() as void{
        onServerStartedEvent();
        onServerStoppedEvent();
    }
}