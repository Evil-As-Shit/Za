extends UINPC

func _update(id:int):
	if (not GameData.worker_stats.has(id)):
		visible = false
		return
	visible = true
	
	$Label.text = str(
			"Clean:",GameData.get_worker_stat(id, "abil_clean"),"\n",
			"Cook:",GameData.get_worker_stat(id, "abil_cook"),"\n",
			"Hosp:",GameData.get_worker_stat(id, "abil_hospitable"),"\n",
			"Stamina:",GameData.get_worker_stat(id, "abil_stamina"),"\n",
			)
