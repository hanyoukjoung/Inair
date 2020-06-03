package kr.or.inair.aiimitlist.service;
import kr.or.inair.aiimitlist.dao.IAIIMITListDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IAIIMITListServiceImpl implements IAIIMITListService {
	@Autowired
	private IAIIMITListDao aiIMITListDao;

}
