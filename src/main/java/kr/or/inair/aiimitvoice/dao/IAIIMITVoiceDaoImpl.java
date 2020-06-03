package kr.or.inair.aiimitvoice.dao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class IAIIMITVoiceDaoImpl implements IAIIMITVoiceDao {
	@Autowired
	private SqlMapClient client;

}
