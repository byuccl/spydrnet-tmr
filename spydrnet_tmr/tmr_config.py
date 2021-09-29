from support_files.vendor_names import XILINX


class TMRConfig:
    def __init__(self, tmr_config):
        self._vendor_name = XILINX
        self._instances_to_replicate = set()
        self._ports_to_replicate = set()
        # self._valid_voter_points
        self._reduction_voter_valid_points = set()
        self._voters_before_ff_valid_points = set()
        self._voters_after_ff_valid_points = set()
