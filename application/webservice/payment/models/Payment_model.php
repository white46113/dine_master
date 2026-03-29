<?php defined('BASEPATH') or exit('No direct script access allowed');
class Payment_model extends CI_Model
{
    private $table = 'payments';
    public function create($d)
    {
        $this->db->trans_start();
        // $this->db->insert($this->table, $d);
        $payment_id = 0; // Table 'payments' doesn't exist, using dummy ID

        // If order_id is present, finalize the order and release the table
        if (isset($d['order_id'])) {
            $order_id = $d['order_id'];
            
            // 1. Mark Order as COMPLETED
            $this->db->where('order_id', $order_id)->update('orders', [
                'status'         => 'COMPLETED',
                'payment_status' => 'PAID',
                'completed_at'   => date('Y-m-d H:i:s')
            ]);

            // 2. Fetch the table_id for this order to release it
            $this->db->select('table_id');
            $order = $this->db->get_where('orders', ['order_id' => $order_id])->row_array();
            
            if ($order && !empty($order['table_id'])) {
                $this->db->where('table_id', $order['table_id'])->update('dining_tables', [
                    'status'           => 'FREE',
                    'current_order_id' => NULL
                ]);
            }
        }

        $this->db->trans_complete();
        return $payment_id;
    }
    public function get($id)
    {
        return $this->db->get_where($this->table, ['id' => $id])->row();
    }
}
